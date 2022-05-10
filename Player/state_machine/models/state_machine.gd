class_name StateMachine
extends Node

export var default_state := NodePath()

var current_state

onready var state: State = get_node(default_state)
onready var no_helmet_state = $NoHelmet
onready var helmet_state = $Helmet
onready var freeze_state = $Freeze
onready var death_state = $Death

signal transitioned(state_name)

func _ready() -> void:
	yield(owner, "ready")
	for child in get_children():
		child.state_machine = self
	state.enter()

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)
	
func _process(delta: float) -> void:
	state.update(delta)
	
func _physics_process(delta: float) -> void:
	state.physics_update(delta)
	
func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return
	state.exit()
	state = get_node(target_state_name)
	state.enter(msg)
	emit_signal("transitioned", state.name)
	
