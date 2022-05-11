extends Resource
class_name NewSector

export (Resource) var sector

var sector_data = load("res://NavigationTable/Sectors/main_sector_list.tres")

func new_sector():
	sector_data.sectors.append(sector)
