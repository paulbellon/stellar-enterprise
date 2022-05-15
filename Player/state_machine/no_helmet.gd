extends PlayerState

signal finished_event

func enter(_msg := {}) -> void:
	state_machine.current_state = self
	player.velocity = Vector3.ZERO
	player.ray.enabled = true

func physics_update(_delta: float) -> void:
	player_movement()
	player.ray.check_vision()
	player.flashlight.light_detection()
	
	if Input.is_action_just_pressed("use") && player.flashlight.light_energy == 1:
		player.flashlight.light_energy = 0
		player.flashlight.is_on = false
	elif Input.is_action_just_pressed("use") && player.flashlight.light_energy == 0:
		player.flashlight.light_energy = 1
		player.flashlight.is_on = true
	
#	if Input.is_action_just_pressed("screenshot"):
#		var vpt: Viewport = get_viewport()
#		var tex: Texture = vpt.get_texture()
#		var img: Image = tex.get_data()
#		img.flip_y()
#		img.save_png("user://stuff5.png")

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
		
func speech():
	player.current_chapter = player.chapter_list.current_chapter
	if player.current_chapter.events.size() == 0: return
	# ignore if next event is not for Vilmaya
	if player.current_chapter.events[0].interactible != "Vilmaya": return
	var dialogue_to_play = player.current_chapter.events.front()
	player.dialogue_system_data.talk(dialogue_to_play)
	yield(player.dialogue_system_data, "end_dialogue")
	player.current_chapter.events.remove(0)
	emit_signal("finished_event")
	
func on_Being_catch():
	state_machine.transition_to("Freeze")
	player.hud.collapse()
