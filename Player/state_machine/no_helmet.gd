extends PlayerState

func enter(_msg := {}) -> void:
	player.velocity = Vector3.ZERO
	player.flashlight.hide()
	
	player.move_lock_x = false
	player.move_lock_y = false
	player.move_lock_z = false

func physics_update(_delta: float) -> void:
	player_movement()
	player.ray.check_vision()

func player_movement():
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
		player.velocity = player.move_and_slide_with_snap(player.velocity, player.snap_vec, Vector3.UP, true, 4, PI)
		
func on_Radio_play():
	state_machine.transition_to("Freeze")
		
