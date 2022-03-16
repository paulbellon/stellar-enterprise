extends KinematicBody
class_name LightTarget

onready var flashlight

var speed = 0.9

func _ready():
	if has_node("../Player/Head/Flashlight"):
		flashlight = $"../Player/Head/Flashlight"
	else:
		return

func _physics_process(delta):
	if flashlight && flashlight.is_lit == true:
		var target_pos = global_transform.origin
		var focus_pos = flashlight.focus_point.global_transform.origin
		var target_to_focus = target_pos.direction_to(focus_pos)
		
		translate(target_to_focus * delta * speed)
	else:
		return
		
	check_collision()

func check_collision():
	for ray in $Sensors.get_children():
		if ray.is_colliding():
			print("ouch")
		else:
			return
