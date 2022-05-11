extends Node

export (Resource) var chapter_list

func _ready():
	chapter_list.connect("event_change", self, "change_chapter")
	chapter_list.current_chapter = chapter_list.chapters.pop_front()

func change_chapter():
	if chapter_list.current_chapter.events.size() == 0:
		chapter_list.current_chapter = chapter_list.chapters.pop_front()
	else:
		return
