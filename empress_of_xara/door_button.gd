extends Spatial

onready var anim_player = $AnimationPlayer
var is_open = false

func _on_Area_ray_click():
	if is_open:
		anim_player.current_animation = "close_door"
	else:
		anim_player.current_animation = "open_door"

func _on_AnimationPlayer_animation_finished(_anim_name):
	is_open = !is_open
