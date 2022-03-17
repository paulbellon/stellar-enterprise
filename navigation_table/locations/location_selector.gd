extends Spatial

var main_sector_data : SectorList = load("res://navigation_table/sectors/main_sector_list.tres")

func _ready():
	for child in get_children():
		if child.is_in_group("location_selector"):
			var t : RayTarget = child.target
			t.connect("ray_click", self, "select_sector", [child.location_data])

func select_sector(location_data):
	main_sector_data.change_location(location_data)
