class_name PlayerState
extends State

var player : KinematicBody

func _ready() -> void:
	yield(owner, "ready")
	player = owner as KinematicBody

	assert(player != null)
