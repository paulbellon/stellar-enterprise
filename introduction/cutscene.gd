extends Control

# warning-ignore:unused_signal
signal sequence_ended

func _input(_event):
	if Input.is_action_just_pressed("left_mouse"):
		emit_signal("sequence_ended")
		$AudioStreamPlayer/AnimationPlayer.play("SoundFadeOut")
