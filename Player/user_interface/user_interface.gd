extends CanvasLayer

export (Resource) var chapter_list

onready var ui_text = $HUD/Label
onready var ui_crosshair = $HUD/Crosshair
onready var anim_player = $HUD/AnimationPlayer

signal dazzled
signal collapsed

func _ready():
# warning-ignore:return_value_discarded
	connect("collapsed", chapter_list, "pass_out")
	chapter_list.connect("awaken", self, "emerge")

func _on_RayCast_enter_target(title):
	if title == null: return
	ui_text.text = title
	
func _on_RayCast_exit_target():
	ui_text.text = ""

func collapse():
	$HUD/ColorRect.show()
	ui_crosshair.hide()
	anim_player.play("collapse")
	yield(anim_player, "animation_finished")
	emit_signal("collapsed")
	
func emerge():
	owner.timer.start(3.0)
	yield(owner.timer, "timeout")
	anim_player.play_backwards("collapse")
	yield(anim_player, "animation_finished")
	ui_crosshair.show()
	$HUD/ColorRect.hide()
	owner.state_machine.transition_to("NoHelmet")
	
func dazzle():
	$HUD/ColorRect.show()
	anim_player.play("dazzle")
	yield(anim_player, "animation_finished")
	emit_signal("dazzled")
	anim_player.play_backwards("dazzle")
	yield(anim_player, "animation_finished")
	$HUD/ColorRect.hide()
	
