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

#signal chapter_finished
#signal chapter_changed
#
##func change_chapter(new_chapter):
##	current_chapter = new_chapter
##	emit_signal("chapter_changed")
##
##func check_chapter_progress():
##	if current_chapter.progress == current_chapter.max_step:
##		current_chapter.is_completed = true
##		emit_signal("chapter_finished")
##	else:
##		return
