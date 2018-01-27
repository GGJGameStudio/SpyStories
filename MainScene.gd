extends Node

var mob_factory = load("res://IA/IA.tscn")
var packageScene = load("Package/Package.tscn")

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

var distAliceBob = 262140
var distBobPackage = 262140
var loopAB = 0
var loopBP = 0

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
	
	set_process(true)

func _process(delta):
	process_vibration(delta)
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

func process_vibration(delta):
	loopAB += delta
	loopBP += delta
	
	if loopAB > 5 && loopAB <= 5.5 :
		_calc_distAliceBob()
		Input.start_joy_vibration(0, distAliceBob, 0)
	elif loopAB > 5.5 :
		Input.stop_joy_vibration(0)
		loopAB = 0
	
	if loopBP > 6 && loopBP <= 6.5 :
		_calc_distBobPackage()
		Input.start_joy_vibration(1, 1-distBobPackage, 0)
	elif loopBP > 6.5 :
		Input.stop_joy_vibration(1)
		loopBP = 0
		
	if alice.is_a_parent_of(package) && distAliceBob < 0.1 && alice.get_node("Sprite").acting :
		alice.remove_child(package)
		bob.add_child(package)
		Input.start_joy_vibration(1, 0, 1, 1)
		
	var d = String(distBobPackage)
	get_node("Distance").set_text(d)

func _calc_distAliceBob():
	var dist = alice.get_global_pos().distance_to(bob.get_global_pos())
	if dist >= 300 : 
		distAliceBob = 1
	else :
		distAliceBob = dist/300

func _calc_distBobPackage():
	var dist = bob.get_global_pos().distance_to(package.get_global_pos())
	if dist >= 300 : 
		distBobPackage = 1
	else :
		distBobPackage = dist/300