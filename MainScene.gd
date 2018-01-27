extends Node

var mob_factory = load("res://IA/IA.tscn")
var packageScene = load("res://Package/Package.tscn")

onready var alice = get_node("Alice")
onready var charlie = get_node("Charlie")
onready var bob = get_node("Bob")
onready var erin = get_node("Erin")

var width = Globals.get("display/width")
var height = Globals.get("display/height")
var center = Vector2(width / 2, height / 2)

var last_spawn = 0
var spawn_interval = 3

onready var package = packageScene.instance()

func _ready():
	alice.controller = 0
	alice.joystick_side = 0
	alice.add_child(package)
	
	charlie.controller = 0
	charlie.joystick_side = 1
	
	bob.controller = 1
	bob.joystick_side = 0
	
	erin.controller = 1
	erin.joystick_side = 1
	
	var spy_vibrator = get_node("SpyVibrator")
	var transmission = get_node("Transmission")
	
	spy_vibrator.alice = alice
	spy_vibrator.bob = bob
	spy_vibrator.charlie = charlie
	spy_vibrator.package = package
	
	transmission.alice = alice
	transmission.bob = bob
	transmission.charlie = charlie
	transmission.erin = erin
	transmission.package = package
	transmission.cia = [alice, bob]
	transmission.kgb = [charlie, erin]
	
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