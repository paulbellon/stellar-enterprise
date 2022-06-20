extends Control

export (Array, AudioStream) var key_types

onready var label = $Label
onready var timer = $Label/Timer
onready var keyboard_sound = $Label/TypingSound

signal sequence_ended

func typing():
	while label.visible_characters != label.get_total_character_count():
		yield(timer, "timeout")
		keyboard_sound.stream = key_types[round(rand_range(0, key_types.size() - 1))]
		keyboard_sound.volume_db = rand_range(-35, -20)
		keyboard_sound.play()
		label.visible_characters += 1
	timer.stop()

func _input(_event):
	if Input.is_action_just_pressed("left_mouse") && timer.is_stopped() == false:
		timer.stop()
		label.visible_characters = label.get_total_character_count()
	elif Input.is_action_just_pressed("left_mouse") && timer.is_stopped() == true:
		emit_signal("sequence_ended")
		$Ambiance/AnimationPlayer.play("SoundFadeOut")
