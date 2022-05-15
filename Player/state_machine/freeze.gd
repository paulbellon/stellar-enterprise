extends PlayerState

func enter(_msg := {}) -> void:
	player.ray.enabled = false
	
#func wake_up():
#	player.timer.start(3.0)
#	yield(player.timer, "timeout")
#	player.hud.emerge()
#	state_machine.transition_to("Helmet")
