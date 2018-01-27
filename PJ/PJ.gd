extends Node2D

var acting = false
var walking = false
var walkingLeft = false
var walkingRight = false

var actionDuration = 0

var velocity = 50

var sprite

func _ready():
	sprite = get_node("Sprite/AnimatedSprite")
	set_process(true)

func _process(delta):
	if !acting && Input.is_action_pressed("ui_select"):
		acting = true
		sprite.set_animation("action")
		actionDuration = 0
	elif acting:
		actionDuration += delta
	
	if actionDuration > 1:
		acting = false
		actionDuration = 0
		sprite.set_animation("idle")
	
	if !acting:
		process_move(delta)

func process_move(delta):
	var zombie_pos = self.get_pos()
	
	if Input.is_action_pressed("ui_right"):
		zombie_pos.x += velocity*delta
		walking = true
		walkingRight = true
		walkingLeft = false
	elif Input.is_action_pressed("ui_left"):
		zombie_pos.x -= velocity*delta
		walking = true
		walkingRight = false
		walkingLeft = true
	else:
		walking = false
	
	if walkingLeft:
		self.set_scale(Vector2(-1,1))
	elif walkingRight:
		self.set_scale(Vector2(1,1))
	
	if walking:
		sprite.set_animation("walk")
	else:
		sprite.set_animation("idle")
	
	self.set_pos(zombie_pos)