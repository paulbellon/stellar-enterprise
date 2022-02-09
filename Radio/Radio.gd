extends Spatial

export (Resource) var chapter_data
export (Resource) var dialogue_system_data

onready var message_player = $Audio


func _ready():
	dialogue_system_data.speaker_reference["Radio"] = message_player

func respond():
	# Ignore if there is no dialogue to play
	if chapter_data.messages.size() == 0: return
	var dialogue_to_play = chapter_data.messages.pop_front()
	dialogue_system_data.talk(dialogue_to_play)
