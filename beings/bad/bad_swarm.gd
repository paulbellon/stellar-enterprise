extends Spatial

export (Resource) var chapter_list
export (NodePath) onready var target_node = get_node(target_node) as Spatial
export (NodePath) onready var path_node = get_node(path_node) as Path
export var FIREFLY_COUNT: int

var fireflies = []
var timer = Timer.new()

onready var bad_being = preload("res://beings/bad/BadBeing.tscn")

func _ready():
	chapter_list.connect("event_change", self, "instanciate_beings")
		
func instanciate_beings():
	if chapter_list.door_is_unlocked == false: return
	for i in FIREFLY_COUNT:
		var firefly = bad_being.instance()
		firefly.connect("caught_player", self, "remove_swarm")
		firefly.target_path = target_node
		$Holder.add_child(firefly)
		fireflies.push_back(firefly)
		
	for firefly in $Holder.get_children():
		firefly.fireflies = fireflies
		
	path_node.is_instanced = true
	
func remove_swarm():
	for firefly in fireflies:
		firefly.area.set_deferred("monitoring", false)
	self.add_child(timer)
	timer.start(3.0)
	yield(timer, "timeout")
	queue_free()
