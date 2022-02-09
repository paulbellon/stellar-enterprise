extends Spatial

var main_sector_data : SectorList = load("res://NavigationTable/Sectors/main_sector_list.tres")

func exit_location():
	main_sector_data.change_location(null)
