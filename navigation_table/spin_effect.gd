extends Spatial

export(float) var rotation_speed = 0.2
export(Vector3) var rotation_axis = Vector3(0,1,0)

func _process(delta):
	rotate_object_local(rotation_axis, (rotation_speed * delta) / 10)
	
