extends Node2D

var controller
var joystick_side
var deadzone = 0.25

func _ready():
	set_process(true)

func _process(delta):
	var sprite = self.get_node("Sprite")
	
	if joystick_side == 0 && Input.is_joy_button_pressed(controller, 12) || joystick_side == 1 && Input.is_joy_button_pressed(controller, 3):
		sprite.start_acting()
	
	var direction = Vector2(Input.get_joy_axis(controller,2*joystick_side), Input.get_joy_axis(controller,2*joystick_side+1))
	
	if abs(direction.x) > deadzone || abs(direction.y) > deadzone:
		sprite.move(direction.normalized(), delta)
	else:
		sprite.start_idle()