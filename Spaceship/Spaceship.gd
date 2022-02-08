extends Spatial

var main_sector_data : SectorList = load("res://NavigationTable/Sectors/main_sector_list.tres") 

func _ready():
	var background_scene = main_sector_data.current_sector.background.instance()
	$Background.add_child(background_scene)
