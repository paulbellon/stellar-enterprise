extends RayCast

var current_target = null

signal enter_target
signal exit_target

func check_vision():
	var collider = get_collider()
	if collider != null && collider is RayTarget:
		var new_target = collider
		if current_target == null:
			current_target = new_target
			current_target.enter()
			emit_signal("enter_target", current_target.display_name)
		elif current_target == new_target:
			current_target.hover()
			if Input.is_action_just_pressed("left_mouse"):
				current_target.click()
			else:
				return false
		else:
			current_target.exit()
			current_target = new_target
			current_target.enter()
	elif current_target != null:
		current_target.exit()
		current_target = null
		emit_signal("exit_target")

