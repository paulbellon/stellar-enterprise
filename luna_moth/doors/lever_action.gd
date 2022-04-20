extends Spatial

onready var anim_player = $AnimationPlayer
onready var sfx = $AudioStreamPlayer3D

var is_open: bool = false

func pull_lever():
	
	if is_open == false:
		anim_player.play("LeverAction")
		yield(anim_player, "animation_finished")
		anim_player.play("DoorAction")
		sfx.play()
		is_open = true
	else:
		anim_player.play_backwards("LeverAction")
		yield(anim_player, "animation_finished")
		anim_player.play_backwards("DoorAction")
		is_open = false

