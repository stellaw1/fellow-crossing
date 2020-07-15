extends Control

func _ready():
	var args = OS.get_cmdline_args()
	# if server is passed, we dont want to show the start 
	# title screen
	if len(args) > 0 and args[0] == "--server":
		get_tree().change_scene("res://World.tscn")

func _on_StartGame_pressed():
	var username = $HBoxContainer/LineEdit.text
	print("start title username:", username)
	
	get_node("/root/Global").setUsername(username)
	print("global username: ", get_node("/root/Global").getUsername())
	
	get_tree().change_scene("res://World.tscn")
