extends Spatial
export (Resource) var sector_data

var is_local = true
var sector_hologram = null
export(PackedScene) var global_hologram

func _ready():
	sector_hologram = sector_data.current_sector.hologram.instance()
	global_hologram = global_hologram.instance()
	update_display()
	
func toggle():
	is_local = !is_local
	update_display()
	$SwitchButton/AudioStreamPlayer3D.play()
	
func update_display():
	for child in $HologramHolder.get_children():
		$HologramHolder.remove_child(child)
	if is_local:
		# Display Local
		$HologramHolder.add_child(sector_hologram)
	else:
		$HologramHolder.add_child(global_hologram)
