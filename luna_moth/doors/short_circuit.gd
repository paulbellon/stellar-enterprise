extends Area

export (Resource) var chapter_list

var is_open: bool = false
var current_chapter

onready var anim_player = $ShutTrigger/AnimationPlayer
onready var active_object = $SecurityPanel

signal has_event
signal finished_event

func _ready():
# warning-ignore:return_value_discarded
	connect("has_event", chapter_list, "set_active_object", [active_object])
# warning-ignore:return_value_discarded
	connect("finished_event", chapter_list, "next_event")
	chapter_list.connect("event_change", self, "check_events")
	
func check_events():
	current_chapter = chapter_list.current_chapter
	var is_event: bool
	if current_chapter.events.size() == 0:
		is_event = false
		return is_event
	if current_chapter.events[0].interactible == "Short circuit":
		emit_signal("has_event")
		is_event = true
		return is_event
	else:
		is_event = false
		return is_event

func short_circuit(body):
	if body.is_in_group("Firefly") && is_open == false && check_events() == true:
		anim_player.current_animation = "DoorOpen"
		is_open = true
		current_chapter.events.remove(0)
		emit_signal("finished_event")
		active_object.set_material_override(null)
	else:
		return
