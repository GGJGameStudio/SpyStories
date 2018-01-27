extends Node2D

var controller
var joystick_side
var paralyzed = false
var paralyse_timer = 0
var deadzone = 0.25

onready var sprite = self.get_node("BuddySprite")

func _ready():
	set_process(true)

func _process(delta):
	if joystick_side == 0 && Input.is_joy_button_pressed(controller, 6) || joystick_side == 1 && Input.is_joy_button_pressed(controller, 7):
		sprite.set_is_running(true)
	else:
		sprite.set_is_running(false)
	
	if paralyzed == true :
		paralyse_timer+=delta
		if paralyse_timer > 2 :
			paralyzed = false
			paralyse_timer = 0
			sprite.start_idle()
	
	if paralyzed == false :
		if joystick_side == 0 && Input.is_joy_button_pressed(controller, 12) || joystick_side == 1 && Input.is_joy_button_pressed(controller, 3):
			sprite.start_acting()
		
		var direction = Vector2(Input.get_joy_axis(controller,2*joystick_side), Input.get_joy_axis(controller,2*joystick_side+1))
		
		if abs(direction.x) > deadzone || abs(direction.y) > deadzone:
			sprite.move(direction.normalized(), delta)
		else:
			sprite.start_idle()

func set_paralyze():
	sprite.start_paralysis()
	paralyzed = true