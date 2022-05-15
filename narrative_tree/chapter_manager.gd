extends Node

export (Resource) var chapter_list

func _ready():
	chapter_list.current_chapter = chapter_list.chapters.pop_front()

func change_chapter():
	if chapter_list.current_chapter.events.size() != 0: return
	else:
		chapter_list.current_chapter = chapter_list.chapters.pop_front()
		chapter_list.next_event()
