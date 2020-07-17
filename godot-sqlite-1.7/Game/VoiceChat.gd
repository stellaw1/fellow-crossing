extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pid
var binary = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	match OS.get_name():
		"OSX":
			binary = "/Applications/Mumble.app/Contents/MacOS/Mumble"
		"Windows":
			binary = "C:\\Program Files\\Mumble\\mumble.exe"
		"X11":
			binary = "mumble"


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_VoiceChat_body_entered(body):
	pid = OS.execute(binary, ["mumble://159.89.171.87"], false)
	print(pid)

func _on_VoiceChat_body_exited(body):
	OS.kill(pid)
