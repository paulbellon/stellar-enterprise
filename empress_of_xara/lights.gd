extends Spatial

func backup_generator(color):
	for light in $OmniCeiling.get_children():
		light.set_color(color)
		light.light_energy = 2.0
	for light in $OmniGround.get_children():
		light.set_color(color)
		light.light_energy = 3.0
