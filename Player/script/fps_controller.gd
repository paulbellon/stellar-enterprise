extends KinematicBody

export (Resource) var chapter_list
export (Resource) var dialogue_system_data

var speed = 2.5
var mouse_sensitivity = 0.06

var direction = Vector3()
var velocity = Vector3()
var snap_vec = Vector3.DOWN

var current_chapter

onready var head = $Head
onready var ray = $Head/Camera/RayCast
onready var flashlight = $Head/Flashlight
onready var camera = $Head/Camera
onready var hud = $Head/Camera/HUDLayer
onready var voice = $Speaker
onready var timer = $Timer
onready var state_machine = $StateMachine

func _ready() -> void:
	Global.player_node = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	ray.enabled = true
	dialogue_system_data.speaker_reference["Vilmaya"] = $Speaker
	dialogue_system_data.timer_reference["Vilmaya"] = $Timer
	
	chapter_list.connect("event_change", state_machine.no_helmet_state, "speech")
	state_machine.no_helmet_state.connect("finished_event", chapter_list, "next_event")

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))
