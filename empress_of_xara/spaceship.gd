extends Spatial

export (Color) var blackout_light

var main_sector_data : SectorList = load("res://navigation_table/sectors/main_sector_list.tres")
var chapter_list : ChapterList = load("res://narrative_tree/chapters/chapter_list.tres")
var current_chapter

onready var player = Global.player_node
onready var hallway_light = []
onready var timer = $Timer

signal event_finished
signal power_off

func _ready():
# warning-ignore:return_value_discarded
	chapter_list.connect("event_change", self, "blackout")
# warning-ignore:return_value_discarded
	connect("event_finished", chapter_list, "next_event")
	
	var background_scene = main_sector_data.current_sector.background.instance()
	$Background.add_child(background_scene)
	
func blackout():
	current_chapter = chapter_list.current_chapter
	if current_chapter.events.size() == 0: return
	if current_chapter.events[0].interactible != "Blackout": return
	# docking sequence initiated
	timer.start(5.0)
	yield(timer, "timeout")
	$Sounds/Crash.play()
	player.camera.shake_camera(0.75)
	current_chapter.events.remove(0)
	emit_signal("event_finished")
	timer.start(1.0)
	yield(timer, "timeout")
	$Sounds/PowerOff.play()
#	# change all lights and material to red
	$Lights.backup_generator(blackout_light)
	timer.start(4.0)
	yield(timer, "timeout")
	emit_signal("power_off")
