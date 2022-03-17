extends PlayerState

func enter(_msg := {}) -> void:
	player.velocity = Vector3.ZERO

func physics_update(_delta: float) -> void:
	player.ray.check_vision()
	player.flashlight.light_detection()
	
	if Input.is_action_pressed("move_forward") \
	or Input.is_action_pressed("move_backward") \
	or Input.is_action_pressed("move_left") \
	or Input.is_action_pressed("move_right"):
		player.direction = Vector3.ZERO
		player.direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		player.direction.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
		player.direction = player.direction.rotated(Vector3.UP, player.rotation.y).normalized()
		player.velocity.x = player.direction.x * player.speed
		player.velocity.z = player.direction.z * player.speed
		player.velocity.y = - 100 * _delta
		player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vec, Vector3.UP, true, 4, PI)
	
	if Input.is_action_just_pressed("use") && player.flashlight.light_energy == 1:
		player.flashlight.light_energy = 0
	elif Input.is_action_just_pressed("use") && player.flashlight.light_energy == 0:
		player.flashlight.light_energy = 1
		
#	if player.ray.trigger_radio():
#		state_machine.transition_to("Freeze")
