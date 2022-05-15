extends KinematicBody

export (Resource) var chapter_list

var current_chapter
var fireflies = []
var speed = rand_range(2.0, 4.0)
var perception_radius = 1.5
var velocity = Vector3()
var acceleration = Vector3()
var friction = 0.05
var target_path = null

var steer_force = 0.8
var avoid_force = 0.6
var cohesion_force = 0.8
var alignement_force = 0.1
var separation_force = 0.8
var chase_force = 1.2
var path_force = 0.8

onready var player = Global.player_node

signal caught_player

func _ready():
	randomize()
	
	transform.origin = Vector3(rand_range(-0.25, 0.25), rand_range(-0.25, 0.25), rand_range(-0.25, 0.25))
	velocity = Vector3(rand_range(-0.5, 0.5), rand_range(-0.5, 0.5), rand_range(-0.5, 0.5)).normalized()
	
	if player:
# warning-ignore:return_value_discarded
		connect("caught_player", player.state_machine.no_helmet_state, "on_Being_catch")

func _physics_process(delta):
	
	var neighbors = get_neighbors(perception_radius)
	
	acceleration += avoid_collision() * avoid_force
	acceleration += process_cohesion(neighbors) * cohesion_force
	acceleration += process_alignement(neighbors) * alignement_force
	acceleration += process_separation(neighbors) * separation_force
	acceleration += process_path(target_path) * path_force
	if cast_ray() && cast_ray().collider == player:
		acceleration += chase_player() * chase_force
	
	velocity = velocity.linear_interpolate(Vector3.ZERO, friction)
	velocity += acceleration * delta
	
# warning-ignore:return_value_discarded
	move_and_collide(velocity * delta, true, false)
	clamp_speed(velocity)

func cast_ray():
	var space_state = get_world().direct_space_state
	if player:
		var result = space_state.intersect_ray(global_transform.origin, player.global_transform.origin, [self])
		return result
	else:
		return

func chase_player():
	var vector = Vector3()
	var being_pos = global_transform.origin
	var player_pos = player.camera.global_transform.origin
	var being_to_player = being_pos.direction_to(player_pos)

	var player_fov = deg2rad(player.camera.fov) / 1.5
	var player_facing = player.global_transform.basis.z
	var cos_angle = being_to_player.dot(player_facing)
	var angle = acos(cos_angle)

	if angle < player_fov:
#		look_at(player_pos, Vector3.UP)
		vector += being_to_player.normalized()
		return steer(vector.normalized() * speed)
	else:
		vector = vector.linear_interpolate(Vector3.ZERO, friction)
		return vector

func catch_player(body):
	if body.name == "Player":
		emit_signal("caught_player")
		for firefly in fireflies:
			firefly.queue_free()
			
func process_path(target_path):
	var vector = Vector3()
	var being_pos = global_transform.origin
	var target_pos = target_path.global_transform.origin
	var being_to_target = being_pos.direction_to(target_pos)
	
	vector += being_to_target.normalized()
	return steer(vector.normalized() * speed)
		
func process_cohesion(neighbors):
	var vector = Vector3()
	if neighbors.empty():
		return vector
	for firefly in neighbors:
		vector += firefly.global_transform.origin
	vector /= neighbors.size()
	return steer((vector - global_transform.origin).normalized() * speed)
	
func process_alignement(neighbors):
	var vector = Vector3()
	if neighbors.empty():
		return vector
	for firefly in neighbors:
		vector += firefly.velocity
	vector /= neighbors.size()
	return steer(vector.normalized() * speed)
	
func process_separation(neighbors):
	var vector = Vector3()
	var close_neighbors = []
	for firefly in neighbors:
		if global_transform.origin.distance_to(firefly.global_transform.origin) <= perception_radius / 2:
			close_neighbors.push_back(firefly)
	if close_neighbors.empty():
		return vector
		
	for firefly in close_neighbors:
		var difference = global_transform.origin - firefly.global_transform.origin
		vector += difference.normalized() / difference.length()
	vector /= close_neighbors.size()
	return steer(vector.normalized() * speed)
	
func avoid_collision():
	var vector = Vector3()
	
	for ray in $Sensors.get_children():
		if ray.is_colliding():
			var repel_direction = ray.get_collision_normal()
			vector += repel_direction
			
			return vector.normalized() * speed
		else:
			return Vector3.ZERO

func get_neighbors(view_radius):
	var neighbors = []
	
	for firefly in fireflies:
		if global_transform.origin.distance_to(firefly.global_transform.origin) <= view_radius \
		and not firefly == self:
			neighbors.push_back(firefly)
	return neighbors
	
func steer(target):
	var steer = target - velocity
	steer = steer.normalized() * steer_force
	return steer
	
func clamp_speed(vector):
	var l = vector.length()
	
	if l > 0.0 && speed < l:
		velocity /= l
		velocity *= speed
