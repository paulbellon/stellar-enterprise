extends Area

onready var player = Global.player_node

export (Resource) var chapter_data
export (Resource) var dialogue_system_data

func _on_body_entered(body):
	if body.name == "Player":
		if chapter_data.monologues.size() == 0: return
		if chapter_data.progress != chapter_data.monologues.front().progress_step: return
		var speech_to_play = chapter_data.monologues.pop_front()
		dialogue_system_data.talk(speech_to_play)
		player.state_machine.helmet_state.is_speaking = true
		yield(dialogue_system_data, "end_dialogue")
		chapter_data.progress += 1
		player.state_machine.helmet_state.is_speaking = false
		queue_free()
