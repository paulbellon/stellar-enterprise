extends Spatial

var main_sector_data : SectorList = load("res://navigation_table/sectors/main_sector_list.tres")

func exit_location():
	if main_sector_data.current_sector.name == "Pan":
		main_sector_data.change_location(main_sector_data.current_sector.locations[0])
