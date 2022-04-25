extends Area

export (Resource) var chapter_data
export (Resource) var speech_system_data

func _on_body_entered(body):
	if body.name == "Player" && chapter_data.sentences.size() != 0:
		var speech_to_play = chapter_data.sentences.pop_front()
		speech_system_data.talk(speech_to_play)
		yield(speech_system_data, "end_sentence")
		queue_free()
