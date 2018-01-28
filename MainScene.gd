extends Node

var mob_factory = load("res://IA/IA.tscn")

var time = 0
var mobs = []

onready var alice = get_node("YSort_Spawn/Alice")
onready var charlie = get_node("YSort_Spawn/Charlie")
onready var bob = get_node("YSort_Spawn/Bob")
onready var erin = get_node("YSort_Spawn/Erin")

onready var exit1 = get_node("Exit1")
onready var exit2 = get_node("Exit2")
onready var postBox = get_node("PostBox")

func _ready():
	randomize()
	
	alice.controller = 0
	alice.joystick_side = 0
	alice.add_to_group("cia")
	global.owner = alice
	
	charlie.controller = 0
	charlie.joystick_side = 1
	charlie.add_to_group("kgb_could_win")
	charlie.add_to_group("kgb")
	
	bob.controller = 1
	bob.joystick_side = 0
	bob.add_to_group("cia_could_win")
	bob.add_to_group("cia")
	
	erin.controller = 1
	erin.joystick_side = 1
	erin.add_to_group("kgb_could_win")
	erin.add_to_group("kgb")
	
	var spy_vibrator = get_node("SpyVibrator")
	
	spy_vibrator.alice = alice.get_node("BuddySprite")
	spy_vibrator.bob = bob.get_node("BuddySprite")
	spy_vibrator.charlie = charlie.get_node("BuddySprite")
	
	get_node("CalmTheme").set_loop(true)
	get_node("CalmTheme").play()
	
	get_node("Train1").already_arrived(true)
	get_node("Train2").arrived_in(2, false)
	get_node("Train3").arrived_in(25, true)
	get_node("Train4").already_arrived(false)
	
	for spawn in get_tree().get_nodes_in_group("spawners"):
		spawn.spawn_area = get_node("YSort_Spawn")
	
	get_node("Train2").set_pos_pj(alice.get_node("BuddySprite"))
	get_node("Train2").set_pos_pj(charlie.get_node("BuddySprite"))
	
	var x = rand_range(100,500)
	var y = rand_range(80,400)
	bob.get_node("BuddySprite").set_global_pos(Vector2(x,y))
	x = rand_range(100,500)
	y = rand_range(80,400)
	erin.get_node("BuddySprite").set_global_pos(Vector2(x,y))
	
	var mob
	
	for i in range(1,15) : 
		x = rand_range(100,500)
		y = rand_range(80,400)
		mob = mob_factory.instance()
		mob.set_global_pos(Vector2(x,y))
		get_node("YSort_Spawn").add_child(mob)
		mob.direction = Vector2(0,0)
		var d = rand_range(1,4)
		mob.duration = d
		mobs.append(mob)
	
	set_process(true)

func _process(delta):
	time+=delta
	if time < 1 :
		for mob in mobs :
			mob.get_node("BuddySprite").start_idle()
	if (time > 3.5) :
		alice.show()
	if (time > 4) :
		charlie.show()