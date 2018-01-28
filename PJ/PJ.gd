extends Node2D

var deadzone = 0.25

func _ready():
	set_process(true)

func _process(delta):
	var sprite = self.get_node("Sprite")
	
	if Input.is_action_pressed("ui_select"):
		sprite.start_acting()
	
	var direction = Vector2(Input.get_joy_axis(0,0), Input.get_joy_axis(0,1))
	
	if abs(direction.x) > deadzone || abs(direction.y) > deadzone:
		sprite.move(direction.normalized(), delta)
	else:
		sprite.start_idle()