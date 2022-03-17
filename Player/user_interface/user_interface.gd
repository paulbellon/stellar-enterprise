extends CanvasLayer

onready var ui_text = $Label
onready var ui_crosshair = $Crosshair

func _on_RayCast_enter_target(title):
	if title == null: return
	ui_text.text = title
	


func _on_RayCast_exit_target():
	ui_text.text = ""
