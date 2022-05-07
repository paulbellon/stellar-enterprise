extends Area

export (Resource) var chapter_list
export (Resource) var dialogue_system_data

onready var player = Global.player_node
onready var current_chapter = chapter_list.current_chapter

func update_chapter_progress():
	current_chapter.progress += 1
	chapter_list.check_chapter_progress()

func _on_body_entered(body):
	if body.name == "Player":
		if current_chapter.monologues.size() == 0: return
		if current_chapter.progress != current_chapter.monologues.front().progress_step: return
		var speech_to_play = current_chapter.monologues.pop_front()
		dialogue_system_data.talk(speech_to_play)
		player.state_machine.helmet_state.is_speaking = true
		yield(dialogue_system_data, "end_dialogue")
		update_chapter_progress()
		player.state_machine.helmet_state.is_speaking = false
		queue_free()
