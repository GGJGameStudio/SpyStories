extends Node2D

enum Action {
	Idle,
	WalkingUp,
	WalkingDown,
	WalkingRight,
	WalkingLeft,
	Acting,
	Paralyzed
}

const medium = sqrt(2)/2

var templatedSprites = [load("res://Sprites/NakedDudeSprite.tscn")]

var last_move = Action.Idle
var acting_since = 0
var velocity = 50

var sprite

func _ready():
	var randomSprite = randi() % templatedSprites.size()
	sprite = templatedSprites[randomSprite].instance()
	add_child(sprite)
	
	set_process(true)

func _process(delta):
	if last_move == Action.Acting:
		acting_since += delta
	
	if acting_since > 1:
		last_move = Action.Idle
		acting_since = 0
		self.start_idle()

func start_idle():
	if last_move != Action.Acting:
		sprite.set_animation("idle")
		last_move = Action.Idle

func start_acting():
	if last_move != Action.Acting:
		sprite.set_animation("action")
		last_move = Action.Acting

func stopped():
	sprite.set_animation(null)
	last_move = Action.Paralyzed

func move(direction, delta):
	if last_move != Action.Acting:
		var current_move
		
		if abs(direction.x) < medium && direction.y < 0:
			current_move = Action.WalkingUp
		elif abs(direction.x) < medium && direction.y > 0:
			current_move = Action.WalkingDown
		elif abs(direction.x) >= medium && direction.x > 0:
			current_move = Action.WalkingRight
		elif abs(direction.x) >= medium && direction.x < 0:
			current_move = Action.WalkingLeft
	
		if current_move != last_move:
			if current_move == Action.WalkingUp:
				sprite.set_animation("walk_up")
			if current_move == Action.WalkingDown:
				sprite.set_animation("walk_down")
			if current_move == Action.WalkingRight:
				sprite.set_animation("walk_right")
			if current_move == Action.WalkingLeft:
				sprite.set_animation("walk_left")
		
		var current_pos = self.get_global_pos()
		get_parent().set_pos(current_pos + direction * velocity * delta)
		
		last_move = current_move