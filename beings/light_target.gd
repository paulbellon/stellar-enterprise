extends KinematicBody
class_name LightTarget

onready var flashlight = get_node_or_null("../Player/Head/Flashlight")

var min_speed = 0.0
var max_speed = 0.6
var velocity = Vector3()
var acceleration = Vector3()
var steer_force = 1.0

func _physics_process(delta):
	
#	avoid_collision()
	
	acceleration += follow_light()
	
	velocity += acceleration * delta
	
	clamp_speed(velocity)
	
	translate(velocity * delta)
	
#	print(velocity.length())
	

#func avoid_collision():
#	var vector = Vector3()
#	for ray in $Sensors.get_children():
#		if ray.is_colliding():
#			var repel_direction = ray.get_collision_normal()
#			velocity += repel_direction
#		else:
#			return

func follow_light():
	var vector = Vector3()
	var target_pos = global_transform.origin
	var focus_pos = flashlight.focus_point.global_transform.origin
	var target_to_focus = target_pos.direction_to(focus_pos)
	
	if flashlight.is_lit == true:
		vector += target_to_focus.normalized()
		
		return steer(vector.normalized() * max_speed)
	else:
		return steer(Vector3(0, 0, 0).normalized())
	
func steer(target):
	var steer = target - velocity
	steer = steer.normalized() * steer_force
	return steer
	
func clamp_speed(vector):
	var l = vector.length()
	
	if l > 0.0 && max_speed < l:
		velocity /= l
		velocity *= max_speed
