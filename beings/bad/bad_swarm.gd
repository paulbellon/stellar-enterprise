extends Spatial

export (Resource) var chapter_list
export (NodePath) onready var target_node = get_node(target_node) as Spatial
export (NodePath) onready var path_node = get_node(path_node) as Path
export var FIREFLY_COUNT: int

var fireflies = []
var timer = Timer.new()

onready var bad_being = preload("res://beings/bad/BadBeing.tscn")
		
func instanciate_beings(body):
	if body.name == "Player":
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
	add_child(timer)
	timer.start(7.0)
	yield(timer, "timeout")
	queue_free()
