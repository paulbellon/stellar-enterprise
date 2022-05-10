extends Spatial

export (Resource) var chapter_list
export (Resource) var sector_data
export(PackedScene) var global_hologram

var is_local = true
var sector_hologram = null

onready var current_chapter = chapter_list.current_chapter
onready var active_object = $SwitchButton/Model

signal has_event
signal finished_event

func _ready():
	connect("has_event", chapter_list, "set_active_object", [active_object])
	connect("finished_event", chapter_list, "next_event")
	chapter_list.connect("event_change", self, "check_events")
	
	sector_hologram = sector_data.current_sector.hologram.instance()
	global_hologram = global_hologram.instance()
	update_display()
	
func check_events():
	var is_event: bool
	if current_chapter.events.size() == 0:
		is_event = false
		return is_event
	if current_chapter.events[0].interactible == "Switch Map":
		emit_signal("has_event")
		is_event = true
		return is_event
	else:
		is_event = false
		return is_event
	
func toggle():
	if check_events() == true:
		current_chapter.events.remove(0)
		emit_signal("finished_event")
		active_object.set_material_override(null)
		is_local = !is_local
		update_display()
		$SwitchButton/AudioStreamPlayer3D.play()
	else:
		return
	
func update_display():
	for child in $HologramHolder.get_children():
		$HologramHolder.remove_child(child)
	if is_local:
		# Display Local
		$HologramHolder.add_child(sector_hologram)
	else:
		$HologramHolder.add_child(global_hologram)
