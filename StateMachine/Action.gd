extends Area

signal ray_enter
signal ray_hover
signal ray_exit
signal ray_click

func enter() -> void:
	emit_signal("ray_enter")
	
func exit() -> void:
	emit_signal("ray_exit")
	
func hover() -> void:
	emit_signal("ray_hover")
	
func click() -> void:
	emit_signal("ray_click")
