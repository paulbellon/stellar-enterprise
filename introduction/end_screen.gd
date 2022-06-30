extends Control

signal sequence_ended

func _unhandled_input(event):
	if $AnimationPlayer.is_playing() == true: return
	if event is InputEventKey or InputEventJoypadButton:
		if event.is_pressed():
			emit_signal("sequence_ended")
