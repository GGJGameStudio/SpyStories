extends Node2D

var controller
var joystick_side
var paralyzed = false
var paralyse_timer = 0
var deadzone = 0.25

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
	
	if paralyzed == false :
		if joystick_side == 0 && Input.is_joy_button_pressed(controller, 12) || joystick_side == 1 && Input.is_joy_button_pressed(controller, 3):
			sprite.start_acting()
			
			for mob in get_tree().get_nodes_in_group("mobs"):
				savate_mob(mob)
			
			for agent in get_tree().get_nodes_in_group("agents"):
				if agent != self && savate_mob(agent):
					# Procéder ici au changement de possession du colis
					# Pourquoi ne pas utiliser un boolean au niveau du PJ au lieu d'un package ?
					# Ensuite, lors de la détection d'une collision avec le PJ (au lieu du package),
					# Tester la condition de victoire ?
					pass
		
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
		return true
	return false

func set_paralyze():
	sprite.start_paralysis()
	paralyzed = true