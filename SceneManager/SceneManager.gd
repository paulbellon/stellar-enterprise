extends Node
export (Resource) var sector_data
export (PackedScene) var default_scene

func _ready():
	sector_data.connect("sector_changed", self, "change_sector")
	sector_data.connect("location_changed", self, "change_location")
	# We are in the ship by default
	switch_scene(default_scene)
	
func switch_scene(next_scene):
	# Removes everything inside
	for child in $MainScene.get_children():
		child.queue_free()
	# Instanciates next scene inside
	var current_scene = next_scene.instance()
	$MainScene.add_child(current_scene)
	
func change_sector(next_sector):
	switch_scene(default_scene)
	for child in $MainScene/Spaceship/Background.get_children():
		child.queue_free()
	var current_sector = next_sector.instance()
	$MainScene/Spaceship/Background.add_child(current_sector)
	
func change_location():
	if sector_data.current_location:
		switch_scene(sector_data.current_location.scene)
	else:
		switch_scene(default_scene)

