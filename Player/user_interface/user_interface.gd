extends CanvasLayer

onready var ui_text = $HUD/Label
onready var ui_crosshair = $HUD/Crosshair
onready var anim_player = $HUD/AnimationPlayer

func _on_RayCast_enter_target(title):
	if title == null: return
	ui_text.text = title
	
func _on_RayCast_exit_target():
	ui_text.text = ""

func collapse():
	$HUD/ColorRect.show()
	ui_crosshair.hide()
	anim_player.play("collapse")
	
func emerge():
	anim_player.play_backwards("collapse")
	yield(anim_player, "animation_finished")
	ui_crosshair.show()
	$HUD/ColorRect.hide()
