extends KinematicBody

onready var player = Global.player_node

func _physics_process(_delta):
	if cast_ray().collider.name == "Player":
		player_vision()
	else:
		return

func cast_ray() -> Dictionary:
	var space_state = get_world().direct_space_state
	var result = space_state.intersect_ray(global_transform.origin, player.global_transform.origin, [self])
	
	return result

func player_vision():
	var being_pos = global_transform.origin
	var player_pos = player.global_transform.origin
	var player_fov = deg2rad(player.camera.fov) / 1.5
	
	var player_facing = player.global_transform.basis.z
	
	var being_to_player = being_pos.direction_to(player_pos).normalized()
	var cos_angle = being_to_player.dot(player_facing)
	var angle = acos(cos_angle)
	
	if angle < player_fov:
		catch_player()
	else:
		return
	
func catch_player():
	var being_pos = global_transform.origin
	var player_pos = player.global_transform.origin
	
	look_at(player.camera.global_transform.origin, Vector3.UP)
	
