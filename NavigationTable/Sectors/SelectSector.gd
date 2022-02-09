extends Spatial

export(Resource) var sector_data
var ray_target = preload("res://Player/RayTarget/RayTarget.tscn")

var target

func _ready():
	add_to_group("sector_selector")
	target = ray_target.instance()
	target.display_name = sector_data.name
	add_child(target)
