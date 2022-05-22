class_name ChapterList
extends Resource

export (Array, Resource) var chapters
export (Material) var active_material

var door_is_shut = false

var current_chapter = null

signal event_change
signal passed_out
signal awaken

func set_active_object(active_object):
	active_object.set_material_override(active_material)
	
func next_event():
	emit_signal("event_change")
	
func pass_out():
	emit_signal("passed_out")
	
func awake():
	emit_signal("awaken")
