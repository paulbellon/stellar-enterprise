extends Node

export (Resource) var chapter_list
export (Resource) var default_chapter


func _ready():
#	chapter_list.connect("chapter_finished", self, "change_chapter")
	chapter_list.current_chapter = chapter_list.chapters.pop_front()

#func change_chapter():
#	if chapter_list.current_chapter.is_completed == true:
#		chapter_list.change_chapter(chapter_list.chapters.pop_front())
