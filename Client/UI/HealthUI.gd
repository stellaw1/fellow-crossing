extends Control

var hearts = 4 setget set_hearts
var max_hearts = 4 setget set_max_hearts
onready var label = $Label

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)

func set_max_hearts(value):
	max_hearts = max(1, value)

func _ready():
	self.max_hearts
