extends Spatial

onready var anim_player = $AnimationPlayer

var is_open: bool = false

func pull_lever():
	if is_open == false:
		anim_player.play("open_door")
		is_open = true
	else:
		anim_player.play("close_door")
		is_open = false
