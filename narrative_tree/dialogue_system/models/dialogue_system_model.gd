extends Resource
class_name DialogueSystemModel

var current_dialogue = null
var speaker_reference = {}
var step = 0

signal start_dialogue
signal end_dialogue
signal change_line 

func talk(data):
	emit_signal("start_dialogue")
	current_dialogue = data.lines
	while step != current_dialogue.size():
		var line = current_dialogue[step]
		var speaker : AudioStreamPlayer3D = speaker_reference[line.speakerName]
		var audio = line.audio
		emit_signal("change_line", line.text)
		speaker.stream = audio
		speaker.play()
		yield(speaker, "finished")
		step += 1
	emit_signal("end_dialogue")