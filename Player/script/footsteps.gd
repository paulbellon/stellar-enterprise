extends AudioStreamPlayer3D

export (Array, AudioStreamSample) var step_sounds

var is_walking = false

func not_walking():
	if !is_walking: return
	yield(self, "finished")
	is_walking = false
	stop()
	
func walking():
	if is_walking: return
	is_walking = true
	play_step()

func play_step():
	var step = round(rand_range(0, step_sounds.size() - 1))
	stream = step_sounds[step]
	play()

func _on_Footsteps_finished():
	play_step()
