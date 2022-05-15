extends PlayerState

func enter(_msg := {}) -> void:
	die()

	player.voice.stop()
	player.voice.stream = null

func die():
	player.ray.enabled = false
	player.move_lock_x = true
	player.move_lock_y = true
	player.move_lock_z = true

	player.hud.collapse()

func wake_up():
	player.timer.start(3.0)
	yield(player.timer, "timeout")
	player.hud.emerge()
	state_machine.transition_to("Helmet")
	print("yey")
	
	
