extends Control
export (Resource) var sector_data

func _ready():
	hide()
	
func notify_change():
	var zone_name = ""
	if sector_data.current_location == null:
		zone_name = "Vilmaya's ship"
	else:
		zone_name = sector_data.current_location.name
	zone_name += ", " + sector_data.current_sector.name
	show()
	$Container2/Label.text = zone_name
	$AnimationPlayer.play("Appear")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play_backwards("Appear")
	yield($AnimationPlayer,"animation_finished")
	hide()
