extends KinematicBody

export (Resource) var chapter_list
export (Resource) var dialogue_system_data

var mouse_sensitivity = 0.06
var joy_sensitivity = 90

var speed = 2.5
var direction = Vector3()
var velocity = Vector3()
var snap_vec = Vector3.DOWN

var current_chapter

onready var ray = $Head/Camera/RayCast
onready var flashlight = $Head/Flashlight
onready var camera = $Head/Camera
onready var footsteps = $Footsteps
onready var hud = $Head/Camera/HUDLayer
onready var timer = $Timer
onready var state_machine = $StateMachine

signal finished_event

func _ready() -> void:
	Global.player_node = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	ray.enabled = true
	dialogue_system_data.speaker_reference["Vilmaya"] = $Speaker
	dialogue_system_data.timer_reference["Vilmaya"] = $Timer
	
	dialogue_system_data.connect("freezing", state_machine, "transition_to")
	dialogue_system_data.connect("unfreezing", state_machine, "transition_to")
	
	chapter_list.connect("event_change", self, "speech")
	# warning-ignore:return_value_discarded
	connect("finished_event", chapter_list, "next_event")
	
	speech()

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		$Head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		$Head.rotation.x = clamp($Head.rotation.x, deg2rad(-89), deg2rad(89))
		return
	
func _process(delta):
	
	var joy_dir_x = Input.get_joy_axis(0, 2)
	var joy_dir_y = Input.get_joy_axis(0, 3)
	if joy_dir_x == 0 && joy_dir_y == 0: return
	rotate_y(deg2rad(-joy_dir_x * joy_sensitivity * delta))
	$Head.rotate_x(deg2rad(-joy_dir_y * joy_sensitivity * delta))
	$Head.rotation.x = clamp($Head.rotation.x, deg2rad(-89), deg2rad(89))
	
func speech():
	current_chapter = chapter_list.current_chapter
	if current_chapter.events.size() == 0: return
	if dialogue_system_data.step != 0: return
	# ignore if next event is not for Vilmaya
	if current_chapter.events[0].interactible != "Vilmaya": return
	var dialogue_to_play = current_chapter.events.front()
	dialogue_system_data.talk(dialogue_to_play)
	yield(dialogue_system_data, "end_dialogue")
	current_chapter.events.remove(0)
	emit_signal("finished_event")
