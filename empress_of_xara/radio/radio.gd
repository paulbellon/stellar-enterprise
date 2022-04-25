extends Spatial

export (Resource) var chapter_data
export (Resource) var dialogue_system_data

export(AudioStreamMP3) var notification_sound

func _ready():
	dialogue_system_data.speaker_reference["Radio"] = $Message
	dialogue_system_data.timer_reference["Radio"] = $Timer
	check_messages()

func check_messages():
	if chapter_data.messages.size() > 0:
		$NotificationAudio.stream = notification_sound
		$NotificationAudio.play()

func respond():
	# Ignore if there is no dialogue to play
	if chapter_data.messages.size() == 0: return
	$NotificationAudio.stop()
	var dialogue_to_play = chapter_data.messages.pop_front()
	dialogue_system_data.chat(dialogue_to_play)
	yield(dialogue_system_data, "end_dialogue")
	check_messages()
