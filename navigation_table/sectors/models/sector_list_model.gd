class_name SectorList
extends Resource

export (Array, Resource) var sectors
export (PackedScene) var map

var current_sector = null
var current_location = null

signal sector_changed
signal location_changed

signal docking
signal set_destination

func change_sector(new_sector):
	current_sector = new_sector
	emit_signal("sector_changed")
	
func change_location(new_location):
	current_location = new_location
	emit_signal("location_changed")
	
func docking():
	emit_signal("docking")

func set_auto_pilot():
	emit_signal("set_destination")
