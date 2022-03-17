extends Spatial

var main_sector_data : SectorList = load("res://navigation_table/sectors/main_sector_list.tres")

func _ready():
	for child in get_children():
		if child.is_in_group("sector_selector"):
			var t : RayTarget = child.target
			t.connect("ray_click", self, "select_sector", [child.sector_data])

func select_sector(sector_data):
	if main_sector_data.current_sector == sector_data :
		print("I can't move the ship in a sector i'am already in")
		return
	print("I want to go to : ", sector_data.name)
	main_sector_data.change_sector(sector_data)
