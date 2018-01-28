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

var templatedSprites = [load("res://Sprites/NakedDudeSprite.tscn"),load("res://Sprites/Guy_1.tscn")]

var last_move = Action.Idle
var acting_since = 0
var velocity = 50
var sprite

func _ready():
	randomize()
	var randomSprite = randi() % templatedSprites.size()
	sprite = templatedSprites[randomSprite].instance()
	sprite.set_scale(Vector2(0.5, 0.5))
	add_child(sprite)
	
	set_process(true)

func _process(delta):
	if last_move == Action.Acting:
		acting_since += delta
	
	if acting_since > 0.5:
		last_move = Action.Idle
		acting_since = 0
		self.start_idle()

func set_is_running(is_running):
	var frames = sprite.frames
	
	frames.set_animation_speed("walk_up", 8 if is_running else 4)
	frames.set_animation_speed("walk_down", 8 if is_running else 4)
	frames.set_animation_speed("walk_left", 8 if is_running else 4)
	frames.set_animation_speed("walk_right", 8 if is_running else 4)
	
	velocity = 100 if is_running else 50

func start_idle():
	if last_move != Action.Acting:
		if last_move == Action.WalkingUp:
			sprite.set_animation("idle_back")
		elif last_move == Action.WalkingDown || last_move == Action.Idle || last_move == Action.Acting: 
			sprite.set_animation("idle_front")
		elif last_move == Action.WalkingRight:
			sprite.set_animation("idle_right")
		elif last_move == Action.WalkingLeft:
			sprite.set_animation("idle_left")
		last_move = Action.Idle

func start_acting():
	if last_move != Action.Acting:
		if last_move == Action.WalkingUp:
			sprite.set_animation("action_back")
		elif last_move == Action.WalkingDown || last_move == Action.Idle:
			sprite.set_animation("action_front")
		elif last_move == Action.WalkingRight:
			sprite.set_animation("action_right")
		elif last_move == Action.WalkingLeft:
			sprite.set_animation("action_left")
		last_move = Action.Acting

func start_paralysis():
	if last_move == Action.WalkingUp:
		sprite.set_animation("falling_back")
	elif last_move == Action.WalkingDown || last_move == Action.Idle || last_move == Action.Acting: 
		sprite.set_animation("falling_front")
	elif last_move == Action.WalkingRight:
		sprite.set_animation("falling_right")
	elif last_move == Action.WalkingLeft:
		sprite.set_animation("falling_left")

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
			elif current_move == Action.WalkingDown:
				sprite.set_animation("walk_down")
			elif current_move == Action.WalkingRight:
				sprite.set_animation("walk_right")
			elif current_move == Action.WalkingLeft:
				sprite.set_animation("walk_left")
		
		var current_pos = self.get_global_pos()
		get_parent().set_pos(current_pos + direction * velocity * delta)
		
		last_move = current_move
		