extends Node

export (Resource) var sector_list
export (PackedScene) var default_scene

onready var chapter_manager = $ChapterManager
onready var anim_player = $OverlayLayer/Transition/AnimationPlayer
onready var timer = $Timer
onready var transition_layer = $OverlayLayer/Transition/ColorRect

onready var dream_scene = $OverlayLayer/DreamViewport/ViewportContainer/Viewport/Dream
onready var dream_viewport = $OverlayLayer/DreamViewport

signal scene_loaded
signal start_dream

func _ready():
	sector_list.connect("sector_changed", self, "change_sector")
	sector_list.connect("location_changed", self, "change_location")
	# We are in the ship by default
	sector_list.current_sector = sector_list.sectors[0]
# warning-ignore:return_value_discarded
	connect("start_dream", dream_scene, "dreaming")
# warning-ignore:return_value_discarded
	connect("scene_loaded", chapter_manager, "change_chapter")
	
	$MainScene.add_child(default_scene.instance())
	anim_player.play_backwards("SceneTransition")
	yield(anim_player, "animation_finished")
	transition_layer.hide()
	
func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
func change_sector():
	transition_layer.show()
	anim_player.play("SceneTransition")
	yield(anim_player, "animation_finished")
	# Removes everything inside
	for child in $MainScene.get_children():
		child.queue_free()
	# Instanciates next scene inside
	emit_signal("start_dream")
	yield(dream_scene, "finished_event")
	$MainScene.add_child(default_scene.instance())
	emit_signal("scene_loaded")
	anim_player.play_backwards("SceneTransition")
	yield(anim_player, "animation_finished")
	transition_layer.hide()
	
func change_location():
	transition_layer.show()
	anim_player.play("SceneTransition")
	yield(anim_player, "animation_finished")
	# Removes everything inside
	for child in $MainScene.get_children():
		child.queue_free()
	# Instanciates next scene inside
	timer.start()
	yield(timer, "timeout")
	$MainScene.add_child(sector_list.current_location.scene.instance())
	emit_signal("scene_loaded")
	anim_player.play_backwards("SceneTransition")
	yield(anim_player, "animation_finished")
	transition_layer.hide()
	
