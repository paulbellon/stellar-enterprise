extends Resource
class_name SpeechSystemModel

var current_sentence = null

signal start_sentence
signal end_sentence
signal change_sentence

func talk(data):
	emit_signal("start_sentence")
	current_sentence = data
	var speaker : AudioStreamPlayer3D = Global.player_node.speaker
	var audio = data.audio
	emit_signal("change_sentence", data.text)
	speaker.stream = audio
	speaker.play()
	yield(speaker, "finished")
	emit_signal("end_sentence")
