extends PlayerState

func enter(_msg := {}) -> void:
	player.move_lock_x = true
	player.move_lock_y = true
	player.move_lock_z = true
	
