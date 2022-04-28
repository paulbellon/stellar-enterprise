extends Area

onready var material = $MeshInstance.get_active_material(0)
onready var light = $SpotLight
onready var godrays = $SpotLight/GodRays

var near_fireflies = 0

func _ready():
	material.emission_enabled = false
	light.light_energy = 0
	
func _process(_delta):
	flickering_light()

func _on_Area_body_entered(body):
	if body.is_in_group("Firefly"):
		near_fireflies += 1

func _on_Area_body_exited(body):
	if body.is_in_group("Firefly"):
		near_fireflies -= 1
		
func flickering_light():
	if near_fireflies != 0:
		material.emission_enabled = true
		light.light_energy = 12
		godrays.show()
	else:
		material.emission_enabled = false
		light.light_energy = 0
		godrays.hide()
