extends Control

signal sequence_ended

func _unhandled_input(event):
	if $AnimationPlayer.is_playing() == true: return
	if event is InputEventKey or InputEventJoypadButton:
		emit_signal("sequence_ended")
