extends Node

var distAliceBob = 262140
var distBobPackage = 262140
var distAliceCharlie = 262140
var loopAB = 0
var loopBP = 0
var duringAC = 0

var alice
var bob
var charlie
var package

func _ready():
	set_process(true)

func _process(delta):
	if duringAC == 0 :
		_calc_distAliceCharlie()
	
	loopAB += delta
	loopBP += delta
	
	if loopAB > distAliceCharlie && duringAC <= 0.5:
		_calc_distAliceBob()
		Input.start_joy_vibration(0, distAliceBob, 0)
		duringAC += delta
	elif duringAC > 0.5 :
		Input.stop_joy_vibration(0)
		loopAB = 0
		duringAC = 0
	
	if loopBP > 6 && loopBP <= 6.5 :
		_calc_distBobPackage()
		Input.start_joy_vibration(1, 1-distBobPackage, 0)
	elif loopBP > 6.5 :
		Input.stop_joy_vibration(1)
		loopBP = 0

func _calc_distAliceCharlie():
	var dist = alice.get_global_pos().distance_to(charlie.get_global_pos())
	if dist >= 300 : 
		distAliceCharlie = 5
	else :
		distAliceCharlie = 5*dist/300

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