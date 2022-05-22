extends Spatial

export (Resource) var chapter_list

var sector_list = load("res://navigation_table/sectors/main_sector_list.tres")
var timer = Timer.new()
var current_chapter

onready var active_object = $ShipWreck/Model

signal has_event
signal finished_event

func _ready():
# warning-ignore:return_value_discarded
	connect("has_event", chapter_list, "set_active_object", [active_object])
# warning-ignore:return_value_discarded
	connect("finished_event", chapter_list, "next_event")
	chapter_list.connect("event_change", self, "check_events")
	
	for child in get_children():
		if child.is_in_group("location_selector"):
			var t : RayTarget = child.target
# warning-ignore:return_value_discarded
			t.connect("ray_click", self, "select_location")

func check_events():
	current_chapter = chapter_list.current_chapter
	var is_event: bool
	if current_chapter.events.size() == 0:
		is_event = false
		return is_event
	if current_chapter.events[0].interactible == "Luna Moth":
		emit_signal("has_event")
		is_event = true
		return is_event
	else:
		is_event = false
		return is_event

func select_location():
	if check_events() == true:
		active_object.set_material_override(null)
		sector_list.docking()
		add_child(timer)
		timer.start(4.0)
		yield(timer, "timeout")
		current_chapter.events.remove(0)
		emit_signal("finished_event")
	else:
		return
