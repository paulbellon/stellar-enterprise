extends Node
export (Resource) var sector_data
export (PackedScene) var default_scene

func _ready():
	sector_data.connect("sector_changed", self, "change_sector")
	sector_data.connect("location_changed", self, "change_location")
	# We are in the ship by default
	sector_data.current_sector = sector_data.sectors[1]
	switch_scene(default_scene)
	
func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit() 
	
func switch_scene(next_scene):
	$TransitionLayer/LoadingScreen.show()
	$TransitionLayer/LoadingScreen/AnimationPlayer.play("Twirl")
	# Removes everything inside
	for child in $MainScene.get_children():
		child.queue_free()
	# Instanciates next scene inside
	var timer = $TransitionLayer/Timer
	timer.start()
	yield(timer, "timeout")
	var current_scene = next_scene.instance()
	$MainScene.add_child(current_scene)
	$TransitionLayer/LoadingScreen.hide()
	$TransitionLayer/LoadingScreen/AnimationPlayer.stop()
	
func change_sector():
	switch_scene(default_scene)
	
func change_location():
	if sector_data.current_location != null:
		switch_scene(sector_data.current_location.scene)
	else:
		switch_scene(default_scene)

