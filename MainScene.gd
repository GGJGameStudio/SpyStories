extends Node

onready var alice = get_node("Alice")
onready var charlie = get_node("Charlie")
onready var bob = get_node("Bob")
onready var erin = get_node("Erin")

var package

var distAliceBob
var distBobPackage
var loopAB
var loopBP

func _ready():
	alice.controller = 0
	alice.joystick_side = 0
	
	charlie.controller = 0
	charlie.joystick_side = 1
	
	bob.controller = 1
	bob.joystick_side = 0
	
	erin.controller = 1
	erin.joystick_side = 1
	
	var packageScene = load("Package/Package.tscn")
	package = packageScene.instance()
	alice.add_child(package)
	
	distAliceBob = 262140
	distBobPackage = 262140
	loopAB = 0
	loopBP = 0
	
	set_process(true)


func _process(delta):
	_calc_distAliceBob()
	#_calc_distBobPackage()
	loopAB += delta
	loopBP += delta
	
	if loopAB > 5 && loopAB <= 5.5 :
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
		
	if alice.is_a_parent_of(package) && distAliceBob < 0.1 && alice.acting :
		alice.remove_child(package)
		bob.add_child(package)
		Input.start_joy_vibration(1, 0, 1, 1)
		


func _calc_distAliceBob():
	var alicePos = alice.get_global_pos()
	var bobPos = bob.get_global_pos()
	var dist = alicePos.distance_to(bobPos)
	if dist >= 300 : 
		distAliceBob = 1
	else :
		distAliceBob = dist/300

#func _calc_distBobPackage():
#	var bobPos = get_node("Bob").get_global_pos()
#	var packagePos = get_node("Package").get_global_pos()
#	var dist = bobPos.distAnce_to(packagePos)
#	if dist >= 100 : 
#		distBobPackage = 1
#	else :
#		distBobPackage = dist/100