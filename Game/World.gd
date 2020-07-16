extends Node2D
# World script
onready var chatBox = $'CanvasLayer/ChatBox'
onready var audioPlayer = $'MusicRegion/AudioStreamPlayer'

func _on_SwitchCoffeeRoom_pressed():
	get_tree().change_scene("res://CoffeeRoom/CoffeeRoomLobby.tscn")


func _on_SwitchCinema_pressed():
	get_tree().change_scene("res://Cinema/CinemaLobby.tscn")

func _on_MusicRegion_body_entered(body):
	if chatBox.mainPlayer and body.name == chatBox.mainPlayer.name:
		print("enter")
		audioPlayer.play()


func _on_MusicRegion_body_exited(body):
	if chatBox.mainPlayer and body.name == chatBox.mainPlayer.name:
		print("exit")
		audioPlayer.stop()
