extends Spatial
export (Resource) var sector_data

var is_local = true

func toggle():
	is_local = !is_local
	update_display()
	
func update_display():
	var current_sector = sector_data.get_current()
	for child in $Map.get_children():
		child.queue_free()
	if is_local:
		var local_view = current_sector.instance()
		$Map.add_child(local_view.map)
	else:
		var global_view = sector_data.instance()
		$Map.add_child(global_view.map)

func _on_Area_ray_click():
	toggle()
