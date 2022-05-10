extends Spatial

var main_sector_data : SectorList = load("res://navigation_table/sectors/main_sector_list.tres")

onready var hallway_ambient = [$Sounds/HallwayAmbient1, $Sounds/HallwayAmbient2]
onready var deck_ambient = $Sounds/DeckAmbient
onready var computer_voice = $Sounds/ComputerVoice
onready var anim_player = $AnimationPlayer

func _ready():
	main_sector_data.connect("docking", self, "initiate_docking")
	main_sector_data.connect("set_destination", self, "auto_pilot")
	
	var background_scene = main_sector_data.current_sector.background.instance()
	$Background.add_child(background_scene)
	
func auto_pilot():
	print("initiating auto pilot")
	
func initiate_docking():
	print("initiating docking sequence")
