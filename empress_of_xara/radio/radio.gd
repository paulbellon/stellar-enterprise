extends Spatial

export (Resource) var chapter_list
export (Resource) var dialogue_system_data

export (AudioStreamMP3) var notification_sound

onready var player = Global.player_node
onready var current_chapter = chapter_list.current_chapter

func _ready():
	dialogue_system_data.speaker_reference["Radio"] = $Message
	dialogue_system_data.timer_reference["Radio"] = $Timer
	check_messages()

func check_messages():
	if current_chapter.messages.size() > 0:
		$NotificationAudio.stream = notification_sound
		$NotificationAudio.play()
		
func update_chapter_progress():
	current_chapter.progress += 1
	chapter_list.check_chapter_progress()

func respond():
	print(current_chapter.progress)
	# Ignore if there is no dialogue to play
	if current_chapter.messages.size() == 0: return
	if current_chapter.progress != current_chapter.messages.front().progress_step: return
	$NotificationAudio.stop()
	var dialogue_to_play = current_chapter.messages.pop_front()
	dialogue_system_data.talk(dialogue_to_play)
	player.state_machine.transition_to("Freeze")
	yield(dialogue_system_data, "end_dialogue")
	update_chapter_progress()
	player.state_machine.transition_to("NoHelmet")
	check_messages()
