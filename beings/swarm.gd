extends Spatial

export var FIREFLY_COUNT: int
export var firefly_scene: PackedScene

var fireflies = []

func _ready():
	
	for i in FIREFLY_COUNT:
		var firefly = firefly_scene.instance()
		add_child(firefly)
		fireflies.push_back(firefly)
	
	for firefly in get_children():
		firefly.fireflies = fireflies
		
