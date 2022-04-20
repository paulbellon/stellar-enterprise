extends Area

onready var anim_player = $AnimationPlayer
var is_open: bool = false

func short_circuit(body):
	if body.is_in_group("Firefly") && is_open == false:
		anim_player.current_animation = "SecurityDoorAction"
		is_open = true
