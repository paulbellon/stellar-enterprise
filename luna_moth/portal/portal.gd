extends Spatial

export (float, 0, 1) var vacuum_force = 0.0

onready var player = Global.player_node
onready var anim_player = $AnimationPlayer

var is_open: bool = false

func _ready():
	player.hud.connect("dazzled", self, "portal_opening")
	
func _physics_process(_delta):
	if is_open == true:
		vacuuming()
	else: return
	
func portal_opening():
	$Ring.show()
	$Effects.show()
	$Area.show()
	anim_player.play("PortalOpen")
	player.state_machine.transition_to("Freeze")
	is_open = true
	vacuuming()
	
func vacuuming():
	var velocity = Vector3()
	var portal_target = global_transform.origin
	var player_target = player.global_transform.origin
	var player_to_portal = player_target.direction_to(portal_target)
	
	velocity += player_to_portal.normalized()
	player.velocity = player.move_and_slide_with_snap(velocity * vacuum_force, player.snap_vec, Vector3.UP, true, 4, PI)
	

