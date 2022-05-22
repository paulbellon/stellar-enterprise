extends Resource
class_name DialogueSystemModel

var current_dialogue = null
var speaker_reference = {}
var timer_reference = {}
var step = 0
var frozen: bool = false


signal start_dialogue
signal freezing
signal unfreezing
signal change_line
signal end_dialogue


func talk(data):
	emit_signal("start_dialogue")
	current_dialogue = data.lines
	while step != current_dialogue.size():
		var line = current_dialogue[step]
		var speaker = speaker_reference[line.speakerName]
		var timer : Timer = timer_reference[line.speakerName]
		var audio = line.audio
		speaker.stream = audio
		if line.quietTime != 0:
			timer.start(line.quietTime)
			yield(timer, "timeout")
		emit_signal("change_line", line.text)
		if line.freezing == true && frozen == false:
			print("frozen")
			frozen = true
			emit_signal("freezing", "Freeze")
		elif line.freezing == false && frozen == true:
			print("unfrozen")
			frozen = false
			emit_signal("unfreezing", "NoHelmet")
		speaker.play()
		yield(speaker, "finished")
		step += 1
	step = 0
	frozen = false
	emit_signal("unfreezing", "NoHelmet")
	emit_signal("end_dialogue")
