extends Node

onready var player_node = null

signal demo_ended

func on_demo_ended():
	emit_signal("demo_ended")
