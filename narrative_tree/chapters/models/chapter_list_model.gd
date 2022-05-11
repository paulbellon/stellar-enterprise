class_name ChapterList
extends Resource

export (Array, Resource) var chapters
export (Material) var active_material

onready var current_chapter = null

signal event_change

func set_active_object(active_object):
	active_object.set_material_override(active_material)
	
func next_event():
	emit_signal("event_change")
