extends Area

onready var anim_player = $AnimationPlayer
var is_open = false

func _on_AnimationPlayer_animation_finished(_anim_name):
	is_open = !is_open


func short_circuit(body):
	if body.is_in_group("Firefly"):
		anim_player.current_animation = "open_door"
