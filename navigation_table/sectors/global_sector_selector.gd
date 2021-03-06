extends Spatial

export (Resource) var chapter_list

var sector_list = load("res://navigation_table/sectors/main_sector_list.tres")
var timer = Timer.new()
var current_chapter

onready var active_object = $Pan/Model

signal has_event
signal finished_event

func _ready():
# warning-ignore:return_value_discarded
	connect("has_event", chapter_list, "set_active_object", [active_object])
# warning-ignore:return_value_discarded
	connect("finished_event", chapter_list, "next_event")
	chapter_list.connect("event_change", self, "check_events")
	
	for child in get_children():
		if child.is_in_group("sector_selector"):
			var t : RayTarget = child.target
# warning-ignore:return_value_discarded
			t.connect("ray_click", self, "select_sector", [child.sector_data])

func check_events():
	current_chapter = chapter_list.current_chapter
	var is_event: bool
	if current_chapter.events.size() == 0:
		is_event = false
		return is_event
	if current_chapter.events[0].interactible == "Pan Sector":
		emit_signal("has_event")
		is_event = true
		return is_event
	else:
		is_event = false
		return is_event

func select_sector(sector_data):
	if sector_list.current_sector == sector_data:
		return
	if check_events() == true:
		add_child(timer)
		emit_signal("finished_event")
		current_chapter.events.remove(0)
		sector_list.set_auto_pilot()
		active_object.set_material_override(null)
		timer.start(9.0)
		yield(timer, "timeout")
		sector_list.change_sector(sector_data)
		timer.queue_free()
	else:
		return
	
	
