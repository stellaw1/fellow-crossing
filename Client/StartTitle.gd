extends Control


func _on_StartGame_pressed():
	var username = $HBoxContainer/LineEdit.text
	print("start title username:", username)
	
	get_node("/root/Global").setUsername(username)
	print("global username: ", get_node("/root/Global").getUsername())
	
	get_tree().change_scene("res://World.tscn")
