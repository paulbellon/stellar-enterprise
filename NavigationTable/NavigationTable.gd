extends Spatial
export (Resource) var sector_data

var is_local = true

func toggle():
	is_local = !is_local
	update_display()
	
func update_display():
	var current_sector = sector_data.get_current()
	for child in $MapLocation.get_children():
		child.queue_free()
	if is_local:
		var local_view = current_sector.map.instance()
		$MapLocation.add_child(local_view)
	else:
		var global_view = sector_data.map.instance()
		$MapLocation.add_child(global_view)
		var index = 0
		var actions = global_view.get_tree().get_nodes_in_group("actions")
		for action in actions:
			action.connect("ray_click", sector_data, "change_sector", [index])
			index += 1

func _on_Area_ray_click():
	toggle()
