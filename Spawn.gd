extends YSort

var mob_factory = load("res://IA/IA.tscn")

var width = Globals.get("display/width")
var height = Globals.get("display/height")
var center = Vector2(width / 2, height / 2)

var last_spawn = 0
var spawn_interval = 3

func _ready():
	set_process(true)

func _process(delta):
	process_spawn(delta)

func process_spawn(delta):
	last_spawn += delta
	
	if last_spawn > spawn_interval:
		var mob = mob_factory.instance()
		mob.set_pos(center)
		self.add_child(mob)
		
		mob.add_to_group("mobs")
		
		last_spawn = 0
	
	for mob in get_tree().get_nodes_in_group("mobs"):
		var mob_pos = mob.get_pos()
		
		if mob_pos.x < -10 || mob_pos.x > width + 10 || mob_pos.y < -10 || mob_pos.y > height + 10:
			mob.remove_from_group("mobs")
			mob.queue_free()
