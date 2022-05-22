extends Spatial

export (Resource) var chapter_list

var current_chapter
var timer = Timer.new()

onready var player = Global.player_node
onready var anim_tree = $AnimationTree

signal crystal_activated

func _ready():
# warning-ignore:return_value_discarded
	connect("crystal_activated", player.hud, "dazzle")
# warning-ignore:return_value_discarded
	connect("crystal_activated", chapter_list, "next_event")

func crystal_acceleration():
	current_chapter = chapter_list.current_chapter
	if current_chapter.events.size() == 0: return
	if current_chapter.events[0].interactible != "Artifact": return
	anim_tree.set("parameters/Acceleration/active", true)
	
func crystal_activation():
	current_chapter.events.remove(0)
	emit_signal("crystal_activated")
	anim_tree.set("parameters/Activation/active", true)
	
func activated():
	queue_free()
	
