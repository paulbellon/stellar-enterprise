extends Spatial

export (Resource) var chapter_list

var main_sector_data : SectorList = load("res://navigation_table/sectors/main_sector_list.tres")

onready var current_chapter = chapter_list.current_chapter
onready var active_object = $MeshInstance

signal has_event
signal finished_event

func _ready():
# warning-ignore:return_value_discarded
	connect("has_event", chapter_list, "set_active_object", [active_object])
# warning-ignore:return_value_discarded
	connect("finished_event", chapter_list, "next_event")
	chapter_list.connect("event_change", self, "check_events")

func check_events():
	var is_event: bool
	if current_chapter.events.size() == 0:
		is_event = false
		return is_event
	if current_chapter.events[0].interactible == "Airlock":
		emit_signal("has_event")
		is_event = true
		return is_event
	else:
		is_event = false
		return is_event

func exit_location():
	if check_events() == true:
		current_chapter.events.remove(0)
		emit_signal("finished_event")
		active_object.set_material_override(null)
		main_sector_data.change_location(main_sector_data.current_sector.locations[0])
	else:
		return
