extends PlayerState

func physics_update(_delta: float) -> void:
	player.direction = Vector3.ZERO
	player.direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	player.direction.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	player.direction = player.direction.rotated(Vector3.UP, player.rotation.y).normalized()
	
	player.velocity.x = player.direction.x * player.speed
	player.velocity.z = player.direction.z * player.speed
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vec, Vector3.UP)
	
	player.ray.check_vision()
#	player.ray.trigger_radio()
