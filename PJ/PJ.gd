extends Node2D

<<<<<<< HEAD
=======
var controller
var joystick_side
var paralyzed = false
var paralyse_timer = 0
>>>>>>> 8769985d0b7b5ccf32a5799fe08bc5a594ce8673
var deadzone = 0.25

export(String) var agent_name

onready var sprite = self.get_node("BuddySprite")

func _ready():
	add_to_group("agents")
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
	
<<<<<<< HEAD
	if Input.is_action_pressed("ui_select"):
		sprite.start_acting()
	
	var direction = Vector2(Input.get_joy_axis(0,0), Input.get_joy_axis(0,1))
=======
	if paralyzed == false :
		if joystick_side == 0 && Input.is_joy_button_pressed(controller, 12) || joystick_side == 1 && Input.is_joy_button_pressed(controller, 3):
			sprite.start_acting()
			
			for mob in get_tree().get_nodes_in_group("mobs"):
				savate_mob(mob)
			
			for agent in get_tree().get_nodes_in_group("agents"):
				if agent != self:
					var areCia = agent.is_in_group("cia") && self.is_in_group("cia")
					var areKgb = agent.is_in_group("kgb") && self.is_in_group("kgb")
					
					if !areCia && !areKgb:
						savate_mob(agent)
					else:
						switch_package(agent)
		
		var direction = Vector2(Input.get_joy_axis(controller,2*joystick_side), Input.get_joy_axis(controller,2*joystick_side+1))
		
		if abs(direction.x) > deadzone || abs(direction.y) > deadzone:
			sprite.move_buddy(direction.normalized(), delta)
		else:
			sprite.start_idle()

func savate_mob(mob):
	var mob_sprite = mob.get_node("BuddySprite")
	var distance = mob_sprite.get_global_pos().distance_to(sprite.get_global_pos())
	
	if distance < 20:
		mob_sprite.start_paralysis()
		get_node("SamplePlayer2D").play("catch_sound")
		
		if global.owner == mob:
			global.owner = self

func switch_package(mob):
	var mob_sprite = mob.get_node("BuddySprite")
	var distance = mob_sprite.get_global_pos().distance_to(sprite.get_global_pos())
>>>>>>> 8769985d0b7b5ccf32a5799fe08bc5a594ce8673
	
	if distance < 20 && global.owner == self:
		global.owner = mob
		get_node("SamplePlayer2D").play("reception_message")

func set_paralyze():
	sprite.start_paralysis()
	paralyzed = true