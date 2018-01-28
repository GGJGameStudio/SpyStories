extends Node2D

enum Direction {
	Up,
	Down,
	Right,
	Left
}

const medium = sqrt(2)/2

var templatedSprites = [load("res://Sprites/NakedDudeSprite.tscn"),load("res://Sprites/Guy_1.tscn")]

var is_acting = false
var is_idle = true
var last_direction = Direction.Down

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
	if is_acting:
		acting_since += delta
	
	if acting_since > 0.5:
		is_acting = false
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
	if !is_acting:
		is_idle = true
		
		if last_direction == Direction.Up:
			sprite.set_animation("idle_back")
		elif last_direction == Direction.Down:
			sprite.set_animation("idle_front")
		elif last_direction == Direction.Right:
			sprite.set_animation("idle_right")
		elif last_direction == Direction.Left:
			sprite.set_animation("idle_left")

func start_acting():
	if !is_acting:
		is_acting = true
		
		if last_direction == Direction.Up:
			sprite.set_animation("action_back")
		elif last_direction == Direction.Down:
			sprite.set_animation("action_front")
		elif last_direction == Direction.Right:
			sprite.set_animation("action_right")
		elif last_direction == Direction.Left:
			sprite.set_animation("action_left")

func start_paralysis():
	if last_direction == Direction.Up:
		sprite.set_animation("falling_back")
	elif last_direction == Direction.Down: 
		sprite.set_animation("falling_front")
	elif last_direction == Direction.Right:
		sprite.set_animation("falling_right")
	elif last_direction == Direction.Left:
		sprite.set_animation("falling_left")

func move(direction, delta):
<<<<<<< HEAD
	
	if last_move != Action.Acting:
		var current_move
=======
	if !is_acting:
		var current_direction
>>>>>>> 6ab9c6b494badb4b8dc18799dd61be69f5a9be31
		
		if abs(direction.x) < medium && direction.y < 0:
			current_direction = Direction.Up
		elif abs(direction.x) < medium && direction.y > 0:
			current_direction = Direction.Down
		elif abs(direction.x) >= medium && direction.x > 0:
			current_direction = Direction.Right
		elif abs(direction.x) >= medium && direction.x < 0:
			current_direction = Direction.Left
	
		if current_direction != last_direction || is_idle:
			if current_direction == Direction.Up:
				sprite.set_animation("walk_up")
			elif current_direction == Direction.Down:
				sprite.set_animation("walk_down")
			elif current_direction == Direction.Right:
				sprite.set_animation("walk_right")
			elif current_direction == Direction.Left:
				sprite.set_animation("walk_left")
		
		var current_pos = self.get_global_pos()
		get_parent().set_pos(current_pos + direction * velocity * delta)
		is_idle = false
		
		last_move = current_move
		
		last_direction = current_direction

