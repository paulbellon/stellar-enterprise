extends Area

export (Resource) var chapter_list

var current_chapter

onready var anim_player = $AnimationPlayer

signal finished_event

func _ready():
# warning-ignore:return_value_discarded
	connect("finished_event", chapter_list, "next_event")

func _on_body_entered(body):
	current_chapter = chapter_list.current_chapter
	if current_chapter.events.size() == 0: return
	if current_chapter.events[0].interactible != "Door shut": return
	if body.name == "Player":
		$CollisionShape.disabled = true
		current_chapter.events.remove(0)
		anim_player.play("DoorShut")
		yield(anim_player, "animation_finished")
		chapter_list.door_is_shut = true
		emit_signal("finished_event")
		queue_free()
