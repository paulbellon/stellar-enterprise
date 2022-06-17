extends PlayerState

func enter(_msg := {}) -> void:
	player.ray.enabled = false
	player.footsteps.not_walking()
	
func physics_update(_delta: float) -> void:
	
	if Input.is_action_just_pressed("use") && player.flashlight.light_energy == 1:
		player.flashlight.light_energy = 0
		player.flashlight.is_on = false
	elif Input.is_action_just_pressed("use") && player.flashlight.light_energy == 0:
		player.flashlight.light_energy = 1
		player.flashlight.is_on = true
