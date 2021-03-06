extends Node2D

var direction = Vector2(0,0)
var duration = 1

const agent_name = null

var acting_since = 0

func _ready():
	add_to_group("mobs")
	set_fixed_process(true)

func _fixed_process(delta):
	acting_since += delta
	
	if acting_since > duration:
		set_new_movement()
	
	if direction.length() > 0:
		get_node("BuddySprite").move_buddy(direction,delta)

func set_new_movement():
	if direction.length() == 0:
		direction = Vector2(rand_range(-1,1),rand_range(-1,1)).normalized()
		duration = randi() % 5
	else:
		direction = Vector2(0,0)
		duration = randi() % 3
		get_node("BuddySprite").start_idle()
	
	acting_since = 0