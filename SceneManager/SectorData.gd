class_name SectorData
extends Resource

export (Array, PackedScene) var sectors_map
export (Array, PackedScene) var sectors_scenes

onready var known_sectors = [
	sector_list["Saturn sector"],
	sector_list["Distress sector"]
]

onready var sector_list = {
	"Saturn sector": {
		"name": "Saturn sector",
		"map": sectors_map[0],
		"scene": sectors_scenes[0]
	},
	"Distress sector": {
		"name": "Distress sector",
		"map": sectors_map[1],
		"scene": sectors_scenes[1]
	}
}

onready var current_sector = known_sectors[0]
