extends Spatial

export (Resource) var chapter_list
export (NodePath) onready var target_node = get_node(target_node) as Spatial
export (NodePath) onready var path_node = get_node(path_node) as Path
export var FIREFLY_COUNT: int

var fireflies = []

onready var bad_being = preload("res://beings/bad/BadBeing.tscn")

func _ready():
	chapter_list.connect("event_change", self, "instanciate_beings")
		
func instanciate_beings():
	if chapter_list.door_is_unlocked == false: return
	for i in FIREFLY_COUNT:
		var firefly = bad_being.instance()
		firefly.target_path = target_node
		add_child(firefly)
		fireflies.push_back(firefly)
		
	for firefly in get_children():
		firefly.fireflies = fireflies
		
	path_node.is_instanced = true
