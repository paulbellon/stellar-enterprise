extends Spatial

onready var player = Global.player_node
onready var anim_player = $AnimationPlayer

signal dream_ended
	
func dreaming():
	owner.dream_viewport.show()
	owner.transition_layer.hide()
	anim_player.play("CameraPan")
	$AudioStreamPlayer.play()
	yield(anim_player, "animation_finished")
	emit_signal("dream_ended")
	owner.transition_layer.show()
	owner.dream_viewport.hide()
