extends KinematicBody

var speed = 7
var mouse_sensitivity = 0.06

var direction = Vector3()
var velocity = Vector3()
var snap_vec = Vector3.DOWN

onready var head = $Head
onready var ray = $Head/Camera/RayCast

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	ray.enabled = true

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-89), deg2rad(89))
