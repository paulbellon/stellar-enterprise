extends KinematicBody
class_name LightTarget

onready var flashlight = Global.player_node.flashlight

var fireflies = []
var speed = rand_range(1.0, 2.0)
var perception_radius = 3
var velocity = Vector3()
var acceleration = Vector3()
var friction = 0.05
var steer_force = 0.8
var avoid_force = 1.0
var cohesion_force = 0.4
var alignement_force = 0.2
var separation_force = 0.8

func _ready():
	randomize()
	
	transform.origin = Vector3(rand_range(-0.5, 0.5), rand_range(-0.5, 0.5), rand_range(-0.5, 0.5))
	velocity = Vector3(rand_range(-1, 1), rand_range(-1, 1), rand_range(-1, 1)).normalized()

func _physics_process(delta):
	
	var neighbors = get_neighbors(perception_radius)
	
	acceleration += avoid_collision() * avoid_force
	acceleration += process_cohesion(neighbors) * cohesion_force
	acceleration += process_alignement(neighbors) * alignement_force
	acceleration += process_separation(neighbors) * separation_force
	
	velocity = velocity.linear_interpolate(Vector3.ZERO, friction)
	velocity += acceleration * delta
	
	translate(velocity * delta)
	clamp_speed(velocity)
	
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

func follow_light():
	var vector = Vector3()
	var target_pos = global_transform.origin
	var focus_pos = flashlight.focus_point.global_transform.origin
	var target_to_focus = target_pos.direction_to(focus_pos)
	
	if flashlight.is_on == true && flashlight.focus_point.overlaps_body(self) == false:
		vector += target_to_focus.normalized()
		return steer(vector.normalized() * speed)
	else:
		vector = vector.linear_interpolate(Vector3.ZERO, friction)
		return vector
	
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
