extends Spatial

export (Resource) var chapter_list

onready var player = Global.player_node
onready var anim_player = $AnimationPlayer

signal finished_event

func _ready():
	chapter_list.connect("passed_out", self, "dreaming")
# warning-ignore:return_value_discarded
	connect("finished_event", chapter_list, "awake")
	
func dreaming():
	owner.timer.start(3.0)
	yield(owner.timer, "timeout")
	owner.dream_viewport.show()
	owner.transition_layer.hide()
	
	anim_player.play("CameraPan")
	$AudioStreamPlayer.play()
	yield(anim_player, "animation_finished")
	emit_signal("finished_event")
	owner.transition_layer.show()
	owner.dream_viewport.hide()
