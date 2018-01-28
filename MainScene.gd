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

var package

var distAliceBob
var distBobPackage
var loopAB
var loopBP

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
	
<<<<<<< HEAD
	#var packageScene = load("Package/Package.tscn")
	#package = packageScene.instance()
	#alice.add_child(package)
	
	distAliceBob = 262140
	distBobPackage = 262140
	loopAB = 0
	loopBP = 0
	
	set_process(true)
	
func _process(delta):
	#_calc_distBobPackage()

	loopAB += delta
	loopBP += delta
	
	if loopAB > 5 && loopAB <= 5.5 :
		_calc_distAliceBob()
		Input.start_joy_vibration(0, distAliceBob, 0)
	elif loopAB > 5.5 :
		Input.stop_joy_vibration(0)
		loopAB = 0
	
	if loopBP > 6 && loopBP <= 6.5 :
		#Input.start_joy_vibration(1, 1-distBobPackage, 0)
		loopBP = 0
	elif loopBP > 6.5 :
		#Input.stop_joy_vibration(1)
		loopBP = 0
		
	#if alice.is_a_parent_of(package) && distAliceBob < 0.1 && alice.acting :
	#	alice.remove_child(package)
	#	bob.add_child(package)
	#	Input.start_joy_vibration(1, 0, 1, 1)
		

func _calc_distAliceBob():
	var alicePos = alice.get_pos()
	var bobPos = bob.get_pos()
	var dist = alicePos.distance_to(bobPos)
	if dist >= 300  : 
		distAliceBob = 1
	else :
		distAliceBob = dist/300

#func _calc_distBobPackage():
#	var bobPos = bob.get_global_pos()
#	var packagePos = package.get_global_pos()
#	var dist = bobPos.distance_to(packagePos)
#	if dist >= 100 : 
#		distBobPackage = 1
#	else :
#		distBobPackage = dist/100
=======
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
>>>>>>> 8769985d0b7b5ccf32a5799fe08bc5a594ce8673
