extends Area

export (Resource) var chapter_list
export (Resource) var dialogue_system_data

onready var player = Global.player_node
onready var current_chapter = chapter_list.current_chapter

signal finished_event

func _ready():
	connect("finished_event", chapter_list, "next_event")

func _on_body_entered(body):
	if current_chapter.events.size() == 0: return
	if current_chapter.events[0].interactible != "Trigger": return
	
	if body.name == "Player":
		$CollisionShape.disabled = true
		var dialogue_to_play = current_chapter.events.front()
		dialogue_system_data.talk(dialogue_to_play)
		if player.state_machine.current_state.name == "Helmet":
			player.state_machine.helmet_state.is_speaking = true
		yield(dialogue_system_data, "end_dialogue")
		current_chapter.events.remove(0)
		emit_signal("finished_event")
		if player.state_machine.current_state.name == "Helmet":
			player.state_machine.helmet_state.is_speaking = false
		queue_free()
