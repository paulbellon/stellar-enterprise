extends Spatial

const FIREFLY_COUNT = 20

onready var firefly_scene = preload("res://beings/Firefly.tscn")

var fireflies = []

func _ready():
	
	for i in FIREFLY_COUNT:
		var firefly = firefly_scene.instance()
		add_child(firefly)
		fireflies.push_back(firefly)
	
	for firefly in get_children():
		firefly.fireflies = fireflies
		
