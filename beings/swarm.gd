extends Spatial

const FIREFLY_COUNT = 20

onready var firefly_scene = preload("res://beings/Firefly.tscn")

var boids = []

func _ready():
	
	for i in FIREFLY_COUNT:
		var boid = firefly_scene.instance()
		add_child(boid)
		boids.push_back(boid)
		
	
	for boid in get_children():
		boid.boids = boids
