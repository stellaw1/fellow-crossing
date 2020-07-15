extends Control

onready var chatLog = $VBoxContainer/RichTextLabel
onready var inputLabel = $VBoxContainer/HBoxContainer/Label
onready var inputField = $VBoxContainer/HBoxContainer/LineEdit

const PORT = 3489
const MAX_PLAYERS = 16
var SPAWN_POINT = Vector2(152, 84)
#const IP = "13.232.157.0"
const IP = "127.0.0.1"

var mainPlayer = null

var Player = load("res://Player/Player.tscn")

var groups = [
	{ 'name': 'Team', 'color': '#34c5f1' },
	{ 'name': 'Match', 'color': '#f1c234' },
	{ 'name': 'Global', 'color': '#ffffff' }
]

var user_name = "unnamed"
var players = { }
var self_data = { name = user_name, position = SPAWN_POINT  }
var group_index = 0

func _ready():
	inputField.connect("text_entered", self, "text_entered")
	get_tree().connect("connected_to_server", self, "enter_room")
	get_tree().connect("network_peer_connected", self, "user_entered")
	get_tree().connect("network_peer_disconnected", self, "user_exited")
	get_tree().connect("server_disconnected", self, "_server_disconnected")
	var args = OS.get_cmdline_args()
	if len(args) > 0 and args[0] == "--server":
		user_name = "bot"
		SPAWN_POINT = Vector2(-1000, -1000)
		command_host()

func text_entered(text):
	if text != "":
		if text[0] == '/':
			if text.substr(1, 7) == "connect":
				command_connect()
			elif text.substr(1, 4) == "host":
				command_host()
			elif text.substr(1, 4) == "name":
				command_name(text.substr(5))
		else:
			var id = get_tree().get_network_unique_id()
			rpc('recieve_message', id, user_name, text)
		inputField.text = ""

func change_group(value):
	group_index += value
	group_index %= groups.size()
	inputLabel.text = '[' + groups[group_index].name + ']'

func add_message(username, text, group=0):
	chatLog.bbcode_text += '\n[color=' + groups[group].color + ']' +  '[' + username + ']: ' + text + '[/color]'

sync func recieve_message(id, user, msg):
	add_message(user, msg, 0)

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ENTER:
			inputField.grab_focus()
		if event.pressed and event.scancode == KEY_ESCAPE:
			inputField.release_focus()
		if event.pressed and event.scancode == KEY_TAB:
			change_group(1)

# commands

func command_host():
	var host = NetworkedMultiplayerENet.new()
	host.create_server(PORT, MAX_PLAYERS)
	get_tree().set_network_peer(host)
	add_message("Engine", "Successfully hosted a server", 2)
	var local_player_id = get_tree().get_network_unique_id()
	players[local_player_id] = self_data
	
	mainPlayer = Player.instance()
	players[local_player_id].sprite = mainPlayer
	mainPlayer.id = local_player_id
	mainPlayer.name = str(local_player_id)
	mainPlayer.set_network_master(local_player_id)
	mainPlayer.position = SPAWN_POINT
	
	var camera = Camera2D.new()
	camera.smoothing_enabled = true
	camera.zoom = Vector2(0.25, 0.25)
	camera.current = true
	
	mainPlayer.add_child(camera)
	$'../../YSort/'.add_child(mainPlayer)
	mainPlayer.label.text = user_name

func command_connect():
	var host = NetworkedMultiplayerENet.new()
	host.create_client(IP, PORT)
	get_tree().set_network_peer(host)

func command_name(name):
	user_name = name
	self_data.name = name
	if mainPlayer != null:
		mainPlayer.label.text = name
		rpc('set_player_name', get_tree().get_network_unique_id(), name)

# multiplayer functions
func enter_room():
	add_message("Engine", "Connected to server", 2)
	var local_player_id = get_tree().get_network_unique_id()
	players[local_player_id] = self_data
	
	mainPlayer = Player.instance()
	players[local_player_id].sprite = mainPlayer
	mainPlayer.id = local_player_id
	mainPlayer.name = str(local_player_id)
	mainPlayer.set_network_master(local_player_id)
	mainPlayer.position = SPAWN_POINT

	var camera = Camera2D.new()
	camera.smoothing_enabled = true
	camera.zoom = Vector2(0.25, 0.25)
	camera.current = true
	
	mainPlayer.add_child(camera)
	$'../../YSort/'.add_child(mainPlayer)
	mainPlayer.label.text = user_name

	rpc('_send_player_info', local_player_id, self_data)

remote func user_entered(connected_player_id):
	var local_player_id = get_tree().get_network_unique_id()
	if not(get_tree().is_network_server()):
		rpc_id(1, '_request_player_info', local_player_id, connected_player_id)


func user_exited(id):
	add_message(players[id].name, "<left the game>", 2)
	players[id].sprite.queue_free()
	players.erase(id)

func _server_disconnected():
	add_message("Engine", "Server Disconnected", 2)
	mainPlayer.queue_free()
	leave_room()

func leave_room():
	get_tree().set_network_peer(null)

remote func _request_player_info(request_from_id, player_id):
	if get_tree().is_network_server():
		rpc_id(request_from_id, '_send_player_info', player_id, players[player_id])

remote func _send_player_info(id, info):
	if get_tree().is_network_server():
		for player_id in players:
			if player_id != id:
				rpc_id(id, '_send_player_info', player_id, players[player_id])
	if not(id in players):
		add_message(info.name, "<joined the game>", 2)
		players[id] = info
		var new_player = Player.instance()
		new_player.set_network_master(id)
		new_player.get_node("Label").text = info.name
		new_player.position = info.position
		new_player.id = id
		new_player.name = str(id)
		players[id].sprite = new_player
		print("add node")
		$'../../YSort/'.add_child(new_player)

func set_player_name(id, name):
	add_message("server", "\"" + players[id].name + "\" changed their name to \"" + name + "\"" )
	players[id].name = name
	players[id].sprite.get_node("Label").text = name

func update_position(id, position):
	players[id].position = position
