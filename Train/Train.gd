extends Node2D

var arrived = false
var is_good_side
var time_to_arrival

onready var sprite = get_node("AnimatedSprite")
onready var spawns = [get_node("Spawn1"), get_node("Spawn2"), get_node("Spawn3"), get_node("Spawn4")]

func _ready():
	sprite.set_animation("hidden")
	set_process(true)

func _process(delta):
	if !arrived:
		if time_to_arrival > 0:
			time_to_arrival -= delta
		
		if time_to_arrival < 0:
			time_to_arrival = 0
		
		if time_to_arrival == 0:
			arrived = true
			for spawn in spawns:
				spawn.spawning = true
				spawn.spawn_limit = 10
				spawn.spawn_interval = 0.5
				spawn.initial_direction = Vector2(-1,0)
				spawn.initial_duration = 7
				spawn.first_delay = 1
			
			sprite.set_animation("arriving_good_side" if is_good_side else "arriving_bad_side")
			sprite.play()

func already_arrived(good_side):	
	arrived = true
	time_to_arrival = 0
	set_good_size(good_side)
	sprite.set_animation("waiting_good_side" if good_side else "waiting_bad_side")
	sprite.play()

func arrived_in(seconds, good_side):
	time_to_arrival = seconds
	set_good_size(good_side)

func set_good_size(good_size):
	is_good_side = good_size
	
	if !good_size:
		for spawn in spawns:
			var pos = spawn.get_pos()
			pos.y = pos.y - 100
			spawn.set_pos(pos)