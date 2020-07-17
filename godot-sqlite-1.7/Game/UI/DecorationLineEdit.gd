extends LineEdit


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			release_focus()


func _on_LineEdit_focus_entered():
	$'../ChatBox'.mainPlayer.is_any_lineedit2_active = true


func _on_LineEdit_focus_exited():
	$'../ChatBox'.mainPlayer.is_any_lineedit2_active = false
