extends Spatial

export (Resource) var chapter_list

onready var player = Global.player_node
onready var anim_player = $AnimationPlayer

signal finished_event
	
func dreaming():
	anim_player.play("CameraPan")
	$Electromagnetic.play()
	$Heartbeat.play()
