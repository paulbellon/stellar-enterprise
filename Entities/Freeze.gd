extends PlayerState

func physics_update(_delta: float) -> void:
	player.ray.enabled = false
	player.move_lock_x = true
	player.move_lock_y = true
	player.move_lock_z = true
	
	#yield(state_machine.transition_to("idle"), "finished")
	
	
	
