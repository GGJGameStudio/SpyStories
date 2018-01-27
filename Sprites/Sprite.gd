extends Node2D

var acting = false
var walking = false

var acting_since = 0

var velocity = 50
var last_direction = Vector2()

onready var sprite = get_node("AnimatedSprite")

func _ready():
	set_process(true)

func _process(delta):
	if acting:
		acting_since += delta
	
	if acting_since > 1:
		acting = false
		acting_since = 0
		self.start_idle()

func start_idle():
	if !acting:
		sprite.set_animation("idle")
		walking = false

func start_acting():
	if !acting:
		sprite.set_animation("action")
		acting = true
		walking = false

func move(direction, delta):
	if !acting:
		var sprite = get_node("AnimatedSprite")
		
		if !walking:
			sprite.set_animation("walk")
			walking = true
		
		var current_pos = self.get_global_pos()
		get_parent().set_pos(current_pos + direction * velocity * delta)
		
		var scale = self.get_scale()
		
		if direction.x < 0:
			scale.x = -1
		elif direction.x > 0:
			scale.x = 1
		
		self.set_scale(scale)
		
		last_direction = direction