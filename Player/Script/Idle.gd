extends PlayerState

func enter(_msg := {}) -> void:
	player.velocity = Vector3.ZERO
	
func update(_delta: float) -> void:
	if Input.is_action_just_pressed("move_forward") \
	or Input.is_action_just_pressed("move_backward") \
	or Input.is_action_just_pressed("move_left") \
	or Input.is_action_just_pressed("move_right"):
		state_machine.transition_to("Run")
		
func physics_update(_delta: float) -> void:
	player.ray.check_vision()
#	if player.ray.trigger_radio():
#		state_machine.transition_to("Freeze")
