extends SpotLight

onready var focus_point = $FocusPoint

var is_lit: bool

func light_detection():
	var light_pos = global_transform.origin
	var max_distance_squared = pow(spot_range, 2)
	var max_angle = deg2rad(spot_angle)

	for target in get_tree().get_nodes_in_group("LightTarget"):

		var target_pos = target.global_transform.origin

		if light_pos.distance_squared_to(target_pos) > max_distance_squared:
			continue

		var light_facing = -global_transform.basis.z

		var light_to_target = light_pos.direction_to(target_pos)
		var light_to_target_norm = light_to_target.normalized()

		var cos_angle = light_to_target_norm.dot(light_facing)
		var angle = acos(cos_angle)

		if angle < max_angle:
			is_lit = true
		else:
			is_lit = false
