extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2.ZERO
const MAX_SPEED = 80
const ACCELERATION = 500
const FRICTION = 500
var DEFAULT_PLAYER = true
var id = 0

const SPAWN_POINT = Vector2(152, 84)

slave var slave_position = Vector2(152, 84)
slave var slave_velocity = Vector2.ZERO
slave var slave_iv = Vector2.ZERO

var temp_position = SPAWN_POINT
var is_any_lineedit1_active = false
var is_any_lineedit2_active = false

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var label = $Label
onready var animationState = animationTree.get("parameters/playback")

var direction = Vector2.ZERO

func _ready():
	animationTree.active = true

func _physics_process(delta):
	if is_network_master():
		if not(is_any_lineedit1_active or is_any_lineedit2_active):
			match state:
				MOVE:
					move_state(delta)
				ROLL:
					pass
				ATTACK:
					attack_state(delta)
			rset('slave_position', position)
	else:
		remote_move_state(delta)

	if get_tree().is_network_server():
		get_node("../../CanvasLayer/ChatBox").update_position(id, position)

func remote_move_state(delta):
	var input_vector = slave_position - position
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		velocity = (slave_position - position) / delta
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)
	
	velocity = move_and_slide(velocity)

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")
		direction = input_vector
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)
	
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	
	if Input.is_action_just_pressed("place_cupboard"):
		var cupboard_position = position + direction * 25
		var cupboard = load("res://Decorations/Cupboard.tscn").instance()
		cupboard.position = cupboard_position
		cupboard.name = v4()
		$'/root/World/YSort/Decorations/'.add_child(cupboard)
		get_node("../../CanvasLayer/ChatBox").broadcast_decoration('cupboard', cupboard.name, cupboard_position)

func place_decoration(decoration_name):
	var decoration_position = position + direction * 25
	var decoration = load("res://Decorations/Cupboard.tscn").instance()
	decoration.position = decoration_position
	decoration.name = v4()
	$'/root/World/YSort/Decorations/'.add_child(decoration)
	get_node("../../CanvasLayer/ChatBox").broadcast_decoration('cupboard', decoration.name, decoration_position)


func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func attack_animation_finished():
	state = MOVE

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

static func getRandomInt(max_value):
  randomize()

  return randi() % max_value

static func randomBytes(n):
	var r = []
	for index in range(0, n):
		r.append(getRandomInt(256))

	return r

static func uuidbin():
  var b = randomBytes(16)

  b[6] = (b[6] & 0x0f) | 0x40
  b[8] = (b[8] & 0x3f) | 0x80
  return b

static func v4():
  var b = uuidbin()

  var low = '%02x%02x%02x%02x' % [b[0], b[1], b[2], b[3]]
  var mid = '%02x%02x' % [b[4], b[5]]
  var hi = '%02x%02x' % [b[6], b[7]]
  var clock = '%02x%02x' % [b[8], b[9]]
  var node = '%02x%02x%02x%02x%02x%02x' % [b[10], b[11], b[12], b[13], b[14], b[15]]

  return '%s-%s-%s-%s-%s' % [low, mid, hi, clock, node]
