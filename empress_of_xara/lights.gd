extends Spatial

func backup_generator(color):
	for light in $OmniCeiling.get_children():
		light.set_color(color)
		light.light_energy = 1.0
	for light in $OmniGround.get_children():
		light.set_color(color)
		light.light_energy = 2.0
	for bulb in $Bulbs.get_children():
		var material = bulb.get_active_material(0)
		material.emission = Color(0.74, 0.18, 0.18)
		material.emission_energy = 4.0
