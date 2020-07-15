extends Node2D
# World script


func _on_SwitchCoffeeRoom_pressed():
	get_tree().change_scene("res://CoffeeRoom/CoffeeRoomLobby.tscn")


func _on_SwitchCinema_pressed():
	get_tree().change_scene("res://Cinema/CinemaLobby.tscn")
