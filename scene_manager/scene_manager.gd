extends Node

export (Resource) var sector_list
export (PackedScene) var default_scene
export (PackedScene) var diary_scene
export (PackedScene) var title_scene
export (PackedScene) var end_scene
export (Array) var intro_sequences

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
# warning-ignore:return_value_discarded
	Global.connect("demo_ended", self, "end")
	
#	title_screen()
#	introduction()
	start()
	
func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
	if Input.is_action_just_pressed("screenshot"):
		var vpt: Viewport = get_viewport()
		var tex: Texture = vpt.get_texture()
		var img: Image = tex.get_data()
		img.flip_y()
		img.save_png("user://stuff02.png")
		
func title_screen():
	timer.start(2.0)
	yield(timer, "timeout")
	anim_player.play("SceneTransition")
	var title = title_scene.instance()
	add_child(title)
	yield(title, "sequence_ended")
	anim_player.play_backwards("SceneTransition")
	yield(anim_player, "animation_finished")
	title.queue_free()
	timer.start(1.0)
	yield(timer, "timeout")
	introduction()
	
func introduction():
	var step = 0
	var sequence
	while step != intro_sequences.size():
		sequence = intro_sequences[step]
		if sequence is DiaryText:
			anim_player.play("SceneTransition")
			var diary = diary_scene.instance()
			add_child(diary)
			diary.label.text = sequence.text
			diary.typing()
			yield(diary, "sequence_ended")
			anim_player.play_backwards("SceneTransition")
			yield(anim_player, "animation_finished")
			diary.queue_free()
			timer.start(2.0)
			yield(timer, "timeout")
			step += 1
		if sequence is PackedScene:
			anim_player.play("SceneTransition")
			var cutscene = sequence.instance()
			add_child(cutscene)
			yield(cutscene, "sequence_ended")
			anim_player.play_backwards("SceneTransition")
			yield(anim_player, "animation_finished")
			cutscene.queue_free()
			timer.start(2.0)
			yield(timer, "timeout")
			step += 1
	start()
			
func start():
	$MainScene.add_child(default_scene.instance())
	anim_player.play("SceneTransition")
	yield(anim_player, "animation_finished")
	transition_layer.hide()
	
func end():
	transition_layer.show()
	anim_player.play_backwards("SceneTransition")
	yield(anim_player, "animation_finished")
	for child in $MainScene.get_children():
		child.queue_free()
	timer.start()
	yield(timer, "timeout")
	anim_player.play("SceneTransition")
	var end_screen = end_scene.instance()
	add_child(end_screen)
	yield(end_screen, "sequence_ended")
	anim_player.play_backwards("SceneTransition")
	yield(anim_player, "animation_finished")
	get_tree().quit()
	
func change_sector():
	transition_layer.show()
	anim_player.play_backwards("SceneTransition")
	yield(anim_player, "animation_finished")
	# Removes everything inside
	for child in $MainScene.get_children():
		child.queue_free()
	# Instanciates next scene inside
	timer.start(3.0)
	yield(timer, "timeout")
	dream_viewport.show()
	anim_player.play("SceneTransition")
	emit_signal("start_dream")
	yield(dream_scene, "finished_event")
	anim_player.play_backwards("SceneTransition")
	yield(anim_player, "animation_finished")
	dream_viewport.hide()
	timer.start(1.0)
	yield(timer, "timeout")
	$MainScene.add_child(default_scene.instance())
	emit_signal("scene_loaded")
	anim_player.play("SceneTransition")
	yield(anim_player, "animation_finished")
	transition_layer.hide()
	
func change_location():
	transition_layer.show()
	anim_player.play_backwards("SceneTransition")
	yield(anim_player, "animation_finished")
	# Removes everything inside
	for child in $MainScene.get_children():
		child.queue_free()
	# Instanciates next scene inside
	timer.start()
	yield(timer, "timeout")
	$MainScene.add_child(sector_list.current_location.scene.instance())
	emit_signal("scene_loaded")
	anim_player.play("SceneTransition")
	yield(anim_player, "animation_finished")
	transition_layer.hide()
	
