extends Resource
class_name DialogueSystemModel

var current_dialogue = null
var speaker_reference = {}
var timer_reference = {}
var step = 0

signal start_dialogue
signal end_dialogue
signal change_line

func talk(data):
	emit_signal("start_dialogue")
	current_dialogue = data.lines
	while step != current_dialogue.size():
		var line = current_dialogue[step]
		var speaker = speaker_reference[line.speakerName]
		var timer : Timer = timer_reference[line.speakerName]
		var audio = line.audio
		emit_signal("change_line", line.text)
		speaker.stream = audio
		if line.quietTime != 0:
			timer.start(line.quietTime)
			yield(timer, "timeout")
		speaker.play()
		yield(speaker, "finished")
		step += 1
	emit_signal("end_dialogue")
	step = 0
