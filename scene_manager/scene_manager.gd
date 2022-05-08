extends Node

export (Resource) var sector_list
export (PackedScene) var default_scene

signal scene_loaded

func _ready():
	sector_list.connect("sector_changed", self, "change_sector")
	sector_list.connect("location_changed", self, "change_location")
	# We are in the ship by default
	sector_list.current_sector = sector_list.sectors[0]
	switch_scene(default_scene)
	
func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit() 
	
func switch_scene(next_scene):
	# Removes everything inside
	for child in $MainScene.get_children():
		child.queue_free()
	# Instanciates next scene inside
	var timer = $OverlayLayer/Timer
	timer.start()
	yield(timer, "timeout")
	var current_scene = next_scene.instance()
	$MainScene.add_child(current_scene)
	emit_signal("scene_loaded")
	
func change_sector():
	switch_scene(default_scene)
	
func change_location():
	if sector_list.current_location != null:
		switch_scene(sector_list.current_location.scene)
	else:
		switch_scene(default_scene)

