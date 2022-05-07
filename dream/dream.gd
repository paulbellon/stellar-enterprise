extends Spatial

onready var anim_player = $AnimationPlayer

func _ready():
	anim_player.play("CameraPan")
