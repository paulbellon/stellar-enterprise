extends Spatial

export (Resource) var chapter_data
export (Resource) var dialogue_system_data

export (AudioStreamMP3) var notification_sound

onready var player = Global.player_node

signal radio_play
signal radio_stop

func _ready():
	dialogue_system_data.speaker_reference["Radio"] = $Message
	dialogue_system_data.timer_reference["Radio"] = $Timer
	check_messages()
	
	if player:
		connect("radio_play", player.state_machine.state, "on_Radio_play")
		connect("radio_stop", player.state_machine.freeze_state, "on_Radio_stop")

func check_messages():
	if chapter_data.messages.size() > 0:
		$NotificationAudio.stream = notification_sound
		$NotificationAudio.play()

func respond():
	# Ignore if there is no dialogue to play
	if chapter_data.messages.size() == 0: return
	if chapter_data.progress != chapter_data.messages.front().progress_step: return
	$NotificationAudio.stop()
	var dialogue_to_play = chapter_data.messages.pop_front()
	dialogue_system_data.talk(dialogue_to_play)
	emit_signal("radio_play")
	yield(dialogue_system_data, "end_dialogue")
	chapter_data.progress += 1
	emit_signal("radio_stop")
	check_messages()
