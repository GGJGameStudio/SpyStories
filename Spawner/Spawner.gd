extends Node2D

var mob_factory = load("res://IA/IA.tscn")

var width = Globals.get("display/width")
var height = Globals.get("display/height")

var spawn_area

var spawning = false
var last_spawn = 0
var spawn_interval = 3
var spawn_limit = -1
var nb_spawn = 0
var first_delay = 0
var delay = 0

var initial_direction
var initial_duration

func _ready():
	add_to_group("spawners")
	set_process(true)

func _process(delta):
	if spawning:
		if first_delay >= delay:
			delay += delta
		
		if first_delay <= delay:
			last_spawn += delta
			
			if last_spawn > spawn_interval && (spawn_limit == -1 || spawn_limit > nb_spawn):
				nb_spawn += 1
				
				var pos = get_global_pos()
				pos.y = pos.y + rand_range(0,30)
				
				var mob = mob_factory.instance()
				
				mob.set_pos(pos)
				mob.add_to_group("mobs")
				
				mob.duration = initial_duration
				mob.direction = initial_direction
				
				spawn_area.add_child(mob)
				
				last_spawn = 0
	
	for mob in get_tree().get_nodes_in_group("mobs"):
		var mob_pos = mob.get_global_pos()
		
		if mob_pos.x < -20 || mob_pos.x > width + 20 || mob_pos.y < -20 || mob_pos.y > height + 20:
			mob.remove_from_group("mobs")
			mob.queue_free()
