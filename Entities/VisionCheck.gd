extends RayCast

var current_selection = null

func check_vision():
	if get_collider():
		var new_selection = get_collider()
		if current_selection == null:
			current_selection = new_selection
			current_selection.enter()
		elif current_selection == new_selection:
			current_selection.hover()
			if Input.is_action_just_pressed("left_mouse"):
				current_selection.click()
			else:
				return false
		else:
			current_selection.exit()
			current_selection = new_selection
			current_selection.enter()
	elif current_selection != null:
		current_selection.exit()
		current_selection = null

