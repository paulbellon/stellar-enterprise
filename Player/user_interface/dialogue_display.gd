extends Control

export (Resource) var dialogue_system_data

func _ready():
	hide()
	dialogue_system_data.connect("change_line", self , "line_changed")
	dialogue_system_data.connect("start_dialogue", self , "dialogue_started")
	dialogue_system_data.connect("end_dialogue", self , "dialogue_ended")

func line_changed(text):
	$Container/Label.text = text
	
func dialogue_started():
	show()

func dialogue_ended():
	hide()
	
func sentence_changed(text):
	$Container/Label.text = text
	
func sentence_started():
	show()

func sentence_ended():
	hide()
