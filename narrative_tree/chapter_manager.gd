extends Node

export (Resource) var chapter_list

signal chapter_change

func _ready():
# warning-ignore:return_value_discarded
	connect("chapter_change", chapter_list, "next_event")
	change_chapter()

func change_chapter():
	if chapter_list.current_chapter == null:
		chapter_list.current_chapter = chapter_list.chapters.pop_front()
	else:
		chapter_list.current_chapter = chapter_list.chapters.pop_front()
		emit_signal("chapter_change")
