extends Spatial

onready var message_player = $Message

func _on_Area_ray_click():
	message_player.play()
