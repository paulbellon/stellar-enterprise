extends PlayerState

func enter(_msg := {}) -> void:
	state_machine.current_state = self
	player.velocity = Vector3.ZERO
	player.ray.enabled = true

func physics_update(_delta: float) -> void:
	player_movement()
	player.ray.check_vision()
	
	if Input.is_action_just_pressed("use"):
		player.flashlight.light_switch()

func player_movement():
	var key_dir_x = Input.get_axis("move_left", "move_right")
	var key_dir_z = Input.get_axis("move_forward", "move_backward")
	var key_direction = Vector3(key_dir_x, 0, key_dir_z)
	
	var joy_dir_x = Input.get_joy_axis(0, 0)
	var joy_dir_z = Input.get_joy_axis(0, 1)
	var joy_direction = Vector3(joy_dir_x, 0, joy_dir_z)
	
	if joy_direction.length() < 0.2:
		joy_direction = Vector3.ZERO
	
	if key_direction.length() == 0 && joy_direction.length() == 0:
		player.footsteps.not_walking()
		return
	
	var direction = key_direction
	if joy_direction.length() > key_direction.length():
		direction = joy_direction
		
	player.direction = direction
	player.direction = player.direction.rotated(Vector3.UP, player.rotation.y).normalized()
	player.velocity.x = player.direction.x * player.speed
	player.velocity.z = player.direction.z * player.speed
	player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vec, Vector3.UP, true, 4, PI)
	
	player.footsteps.walking()
