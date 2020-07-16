extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	destroy()

func destroy():
	$'../../../CanvasLayer/ChatBox'.broadcast_destroy(name)
	queue_free()
