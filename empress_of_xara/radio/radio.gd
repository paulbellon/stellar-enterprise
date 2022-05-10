extends Spatial

export (Resource) var chapter_list
export (Resource) var dialogue_system_data

export (AudioStreamMP3) var notification_sound

onready var player = Global.player_node
onready var current_chapter = chapter_list.current_chapter

onready var active_object = $Mesh

signal incoming_message
signal finished_event

func _ready():
# warning-ignore:return_value_discarded
	connect("incoming_message", chapter_list, "set_active_object", [active_object])
# warning-ignore:return_value_discarded
	connect("finished_event", chapter_list, "next_event")
	chapter_list.connect("event_change", self, "check_events")
	
	dialogue_system_data.speaker_reference["Radio"] = $Message
	dialogue_system_data.timer_reference["Radio"] = $Timer
	
	check_events()

func check_events():
	# checks if next event is for Radio
	var is_event: bool
	if current_chapter.events.size() == 0:
		is_event = false
		return is_event
	if current_chapter.events[0].interactible == "Radio":
		$NotificationAudio.stream = notification_sound
		$NotificationAudio.play()
		emit_signal("incoming_message")
		is_event = true
		return is_event
	else: 
		is_event = false
		return is_event

func respond():
	if check_events() == true:
		active_object.set_material_override(null)
		$NotificationAudio.stop()
		# takes next dialogue event to play
		var dialogue_to_play = current_chapter.events.front()
		dialogue_system_data.talk(dialogue_to_play)
		player.state_machine.transition_to("Freeze")
		yield(dialogue_system_data, "end_dialogue")
		# removes this event from list at the end
		current_chapter.events.remove(0)
		emit_signal("finished_event")
		player.state_machine.transition_to("NoHelmet")
	else:
		return
