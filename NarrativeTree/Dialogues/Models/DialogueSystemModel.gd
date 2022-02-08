extends Resource
class_name DialogueSystemModel

var current_dialogue = null

func talk(data):
	current_dialogue = data.sentences
	for action in data.narrative_actions:
		action.run()
	emit_changed()
