extends Spatial

export (Resource) var chapter_data
export (Resource) var dialogue_system_data

onready var message_player = $Audio

var step = 0

func _ready():
	dialogue_system_data.connect("changed", self, "init_dialogue")

func init_dialogue():
	progress()
	
func progress():
	message_player.stream = dialogue_system_data.current_dialogue[step]
	step += 1

func _on_Area_ray_click():
	var msg = chapter_data.messages.pop_front()
	message_player.play()
	print(step)
	dialogue_system_data.talk(msg)
	print(msg)
	if(step < dialogue_system_data.current_dialogue.size()):
		progress()
	else:
		dialogue_system_data.current_dialogue = null
