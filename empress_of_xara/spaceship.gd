extends Spatial

var main_sector_data : SectorList = load("res://navigation_table/sectors/main_sector_list.tres")
var chapter_list : ChapterList = load("res://narrative_tree/chapters/chapter_list.tres")
var current_chapter = chapter_list.current_chapter

var blackout_color = Vector3(1, 0.26, 0.26)
var timer = Timer.new()

onready var player = Global.player_node

onready var hallway_ambient = []
onready var hallway_light = []

onready var deck_ambient = $Sounds/DeckAmbient
onready var computer_voice = $Sounds/ComputerVoice
onready var anim_player = $AnimationPlayer

signal event_finished

func _ready():
# warning-ignore:return_value_discarded
	main_sector_data.connect("docking", self, "initiate_docking")
# warning-ignore:return_value_discarded
	main_sector_data.connect("set_destination", self, "auto_pilot")
	
	chapter_list.connect("event_change", self, "blackout")
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
	if current_chapter.events.size() == 0: return
	if current_chapter.events[0].interactible != "Blackout": return
	add_child(timer)
	timer.start(5.0)
	yield(timer, "timeout")
	player.hud.anim_player.play("Shake")
	yield(player.hud.anim_player, "animation_finished")
	for light in $Lights.get_children():
		light.light_color = blackout_color
		light.spot_range = 5.0
		light.spot_angle = 35.0
	emit_signal("event_finished")
	timer.queue_free()
