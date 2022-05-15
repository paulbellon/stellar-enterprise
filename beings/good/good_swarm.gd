extends Spatial

export (Resource) var chapter_list
export var FIREFLY_COUNT: int

var fireflies = []

onready var good_being = preload("res://beings/good/GoodBeing.tscn")

func _ready():
	chapter_list.connect("event_change", self, "delete_swarm")
	
	for i in FIREFLY_COUNT:
		var firefly = good_being.instance()
		add_child(firefly)
		fireflies.push_back(firefly)
	
	for firefly in get_children():
		firefly.fireflies = fireflies
		
func delete_swarm():
	if chapter_list.door_is_shut == false: return
	queue_free()
		
