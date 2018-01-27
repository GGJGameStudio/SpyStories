extends Node

var mob_factory = load("res://IA/IA.tscn")

onready var alice = get_node("Alice")
onready var charlie = get_node("Charlie")
onready var bob = get_node("Bob")
onready var erin = get_node("Erin")

var width = Globals.get("display/width")
var height = Globals.get("display/height")
var center = Vector2(width / 2, height / 2)

var last_spawn = 0
var spawn_interval = 3

var mobs = Array()

func _ready():
	alice.controller = 0
	alice.joystick_side = 0
	
	charlie.controller = 0
	charlie.joystick_side = 1
	
	bob.controller = 1
	bob.joystick_side = 0
	
	erin.controller = 1
	erin.joystick_side = 1
	
	set_process(true)

func _process(delta):
	last_spawn += delta
	
	if last_spawn > spawn_interval:
		var mob = mob_factory.instance()
		mob.set_pos(center)
		self.add_child(mob)
		
		mobs.append(mob)
		
		last_spawn = 0
	
	for mob in mobs:
		var mob_pos = mob.get_pos()
		
		if mob_pos.x < -10 || mob_pos.x > width + 10 || mob_pos.y < -10 || mob_pos.y > height + 10:
			mob.free()