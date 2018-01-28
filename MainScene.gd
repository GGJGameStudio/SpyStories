extends Node


onready var alice = get_node("YSort_Spawn/Alice")
onready var charlie = get_node("YSort_Spawn/Charlie")
onready var bob = get_node("YSort_Spawn/Bob")
onready var erin = get_node("YSort_Spawn/Erin")

onready var exit1 = get_node("Exit1")
onready var exit2 = get_node("Exit2")
onready var postBox = get_node("PostBox")

func _ready():
	alice.controller = 0
	alice.joystick_side = 0
	global.owner = alice
	
	charlie.controller = 0
	charlie.joystick_side = 1
	charlie.add_to_group("kgb_could_win")
	
	bob.controller = 1
	bob.joystick_side = 0
	bob.add_to_group("cia_could_win")
	
	erin.controller = 1
	erin.joystick_side = 1
	erin.add_to_group("kgb_could_win")
	
	var spy_vibrator = get_node("SpyVibrator")
	
	spy_vibrator.alice = alice
	spy_vibrator.bob = bob
	spy_vibrator.charlie = charlie
	
	var transmission = get_node("YSort_Spawn/Transmission")
	
	transmission.alice = alice
	transmission.bob = bob
	transmission.charlie = charlie
	transmission.erin = erin
	
	get_node("CalmTheme").set_loop(true)
	get_node("CalmTheme").play()
	
	get_node("Train1").already_arrived(true)
	get_node("Train2").arrived_in(10, false)
	get_node("Train3").arrived_in(25, true)
	get_node("Train4").already_arrived(false)
	
	for spawn in get_tree().get_nodes_in_group("spawners"):
		spawn.spawn_area = get_node("YSort_Spawn")