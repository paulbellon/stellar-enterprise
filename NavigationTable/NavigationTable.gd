extends Spatial
export (Resource) var sector_data

var is_local = true
var sector_hologram = null
onready var global_hologram = $HologramHolder/GlobalMap 

func _ready():
	sector_hologram = sector_data.current_sector.hologram.instance()
	$HologramHolder.add_child(sector_hologram)
	update_display()

func toggle():
	is_local = !is_local
	update_display()
	
func update_display():
	if is_local:
		# Display Local
		global_hologram.hide()
		sector_hologram.show()
	else:
		global_hologram.show()
		sector_hologram.hide()
