extends Spatial

export(Resource) var location_data
var ray_target = preload("res://player/ray_target/RayTarget.tscn")

var target

func _ready():
	add_to_group("location_selector")
	target = ray_target.instance()
	target.display_name = location_data.name
	add_child(target)
