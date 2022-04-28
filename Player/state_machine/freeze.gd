extends PlayerState

func enter(_msg := {}) -> void:
	player.move_lock_x = true
	player.move_lock_y = true
	player.move_lock_z = true
	
func on_Radio_stop():
	print("coucou")
	state_machine.transition_to("NoHelmet")
	
	
	
