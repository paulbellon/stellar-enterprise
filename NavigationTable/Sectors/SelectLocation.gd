extends Spatial

export(Resource) var location_data
var ray_target = preload("res://Player/RayTarget/RayTarget.tscn")

var target

func _ready():
	add_to_group("location_selector")
	target = ray_target.instance()
	add_child(target)
