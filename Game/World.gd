extends Node2D

onready var audioPlayer = $MusicRegion/AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	$CanvasLayer/ChatBox.add_message("engine", body.name + " entered music room")
	if body.id and body.id == get_tree().get_network_unique_id():
		$MusicRegion.join_voice_chat()


func _on_Area2D_body_exited(body):
	$CanvasLayer/ChatBox.add_message("engine", body.name + " exited music room")
	if body.id and body.id == get_tree().get_network_unique_id():
		$MusicRegion.stop_all()
