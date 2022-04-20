extends Area

signal caught_player
onready var player = get_node_or_null("../Player")

func _ready():
	if player:
		connect("caught_player", player.hud, "collapse")

func _physics_process(_delta):
	if cast_ray() && cast_ray().collider.name == "Player":
		player_vision()
	else:
		return

func cast_ray():
	var space_state = get_world().direct_space_state
	if player:
		var result = space_state.intersect_ray(global_transform.origin, player.global_transform.origin, [self])
		return result
	else:
		return

func player_vision():
	var being_pos = global_transform.origin
	var player_pos = cast_ray().collider.camera.global_transform.origin
	var player_fov = deg2rad(cast_ray().collider.camera.fov) / 1.5
	
	var player_facing = cast_ray().collider.global_transform.basis.z
	
	var being_to_player = being_pos.direction_to(player_pos).normalized()
	var cos_angle = being_to_player.dot(player_facing)
	var angle = acos(cos_angle)
	
	if angle < player_fov:
		look_at(player_pos, Vector3.UP)
		translation = being_pos.move_toward(player_pos, 0.03)
	else:
		return

func catch_player(body):
	if body.name == "Player":
		emit_signal("caught_player")
