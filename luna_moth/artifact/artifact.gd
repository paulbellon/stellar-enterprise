extends Spatial

onready var player = Global.player_node

onready var anim_tree = $AnimationTree
onready var anim_player = $AnimationPlayer

signal crystal_activated

func _ready():
	connect("crystal_activated", player.hud, "dazzle")

func crystal_acceleration():
	anim_tree.set("parameters/Acceleration/active", true)
	
func crystal_activation():
	anim_tree.set("parameters/Activation/active", true)
	
func activated():
	emit_signal("crystal_activated")
	
