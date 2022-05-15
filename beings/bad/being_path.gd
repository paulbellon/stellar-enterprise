extends Path

onready var path_follow = $PathFollow

var offset_speed = 2.0
var is_instanced: bool = false setget setterFunc

func _physics_process(delta):
	if is_instanced == true:
		path_follow.set_offset(path_follow.get_offset() + offset_speed * delta)
	else:
		return

func setterFunc(new_value: bool):
	is_instanced = new_value
