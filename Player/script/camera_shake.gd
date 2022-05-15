extends Camera

export (OpenSimplexNoise) var noise
export (float, 0, 1) var trauma = 0.0

export var max_x = 25
export var max_y = 10
export var max_r = 25

export var time_scale = 150
export(float, 0, 1) var decay = 0.2

var time = 0

func _process(delta):
	time += delta
	
	var shake = pow(trauma, 2)
	h_offset = noise.get_noise_3d(time * time_scale, 0, 0) * max_x * shake
	v_offset = noise.get_noise_3d(0, time * time_scale, 0) * max_y * shake
#	rotation_degrees = noise.get_noise_3d(0, 0, time * time_scale) * max_r * shake
	
	if trauma > 0: trauma = clamp(trauma - (delta * decay), 0, 1)
	
func shake_camera(trauma_in):
	trauma = clamp((trauma + trauma_in) / 2, 0, 1)
