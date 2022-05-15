extends Spatial

export (Color) var blackout_light

var main_sector_data : SectorList = load("res://navigation_table/sectors/main_sector_list.tres")
var chapter_list : ChapterList = load("res://narrative_tree/chapters/chapter_list.tres")
var current_chapter

onready var player = Global.player_node

onready var hallway_ambient = []
onready var hallway_light = []

onready var deck_ambient = $Sounds/DeckAmbient
onready var computer_voice = $Sounds/ComputerVoice
onready var timer = $Timer

signal event_finished

func _ready():
# warning-ignore:return_value_discarded
	main_sector_data.connect("docking", self, "initiate_docking")
# warning-ignore:return_value_discarded
	main_sector_data.connect("set_destination", self, "auto_pilot")
# warning-ignore:return_value_discarded
	chapter_list.connect("event_change", self, "blackout")
# warning-ignore:return_value_discarded
	connect("event_finished", chapter_list, "next_event")
	
	var background_scene = main_sector_data.current_sector.background.instance()
	$Background.add_child(background_scene)
	
func auto_pilot():
	print("initiating auto pilot")
#	computer_voice.stream =
#	computer_voice.play()
	
func initiate_docking():
	print("initiating docking sequence")
#	computer_voice.stream =
#	computer_voice.play()
	
func blackout():
	current_chapter = chapter_list.current_chapter
	if current_chapter.events.size() == 0: return
	if current_chapter.events[0].interactible != "Blackout": return
	timer.start(5.0)
	yield(timer, "timeout")
	player.camera.shake_camera(0.75)
	timer.start(2.0)
	yield(timer, "timeout")
	for light in $Lights.get_children():
		light.set_color(blackout_light)
		light.spot_range = 5.0
		light.spot_angle = 35.0
	current_chapter.events.remove(0)
	emit_signal("event_finished")
