extends Sprite

onready var player = get_node("/root/GlobalSprite")
#set default texture to player2
var mytexture = preload("res://Player/Player2Sheet.png")

func _ready():
	set_texture(player.mytexture)
