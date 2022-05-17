extends Spatial

export (Resource) var chapter_list
export (float, 0, 1) var vacuum_force = 0.0

var is_open: bool = false
var timer = Timer.new()

onready var player = Global.player_node
onready var anim_player = $AnimationPlayer

signal player_absorbed

func _ready():
	player.hud.connect("dazzled", self, "portal_opening")
# warning-ignore:return_value_discarded
	connect("player_absorbed", player.hud, "collapse")
	
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
	
func absorbed(body):
	if body.name == "Player":
		emit_signal("player_absorbed")
		add_child(timer)
		timer.start(4.0)
		yield(timer, "timeout")
		get_tree().quit()
	

