class_name SectorList
extends Resource

export (Array, Resource) var sectors
export (PackedScene) var map
var current_sector_id = 0
# This is the spaceship location referenced as null
var current_location = null

signal sector_changed
signal location_changed

func change_sector(new_sector_id):
	current_sector_id = new_sector_id
	emit_signal("sector_changed")
	print("coucou")
	
func change_location(new_location):
	current_location = new_location
	emit_signal("location_changed")
	
func get_current():
	return sectors[current_sector_id]
