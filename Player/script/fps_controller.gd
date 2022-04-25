extends KinematicBody

var speed = 3.5
var mouse_sensitivity = 0.06

var direction = Vector3()
var velocity = Vector3()
var snap_vec = Vector3.DOWN

onready var dialogue_system_data = load("res://narrative_tree/dialogue_system/dialogue_system_data.tres")

onready var head = $Head
onready var ray = $Head/Camera/RayCast
onready var flashlight = $Head/Flashlight
onready var camera = $Head/Camera
onready var hud = $Head/Camera/HUDLayer

func _ready() -> void:
	Global.player_node = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	ray.enabled = true
	dialogue_system_data.speaker_reference["Vilmaya"] = $Speaker
	dialogue_system_data.timer_reference["Vilmaya"] = $Timer

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))
