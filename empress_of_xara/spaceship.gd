extends Spatial

var main_sector_data : SectorList = load("res://navigation_table/sectors/main_sector_list.tres")

#onready var bedroom_spawn = $SpawnPoints/SpawnPoint
#onready var airlock_spawn = $SpawnPoints/SpawnPoint2
#onready var spawnpoints = [bedroom_spawn, airlock_spawn]

func _ready():
	var background_scene = main_sector_data.current_sector.background.instance()
	$Background.add_child(background_scene)
	
#func spawn_player(player):
#	spawnpoints[0].add_child(player)
