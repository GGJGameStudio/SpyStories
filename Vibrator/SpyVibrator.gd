extends Node

var distAliceBob = 262140
var distBobPackage = 262140
var distAliceCharlie = 262140
var distBobCharlie = 262140

var loopAB = 0
var loopBC = 0
var duringAC = 0
var duringBP = 0

var alice
var bob
var charlie
var package

func _ready():
	set_process(true)

func _process(delta):
	if duringAC == 0 :
		_calc_distAliceCharlie()
	if duringBP == 0 :
		_calc_distBobPackage()
	
	loopAB += delta
	loopBC += delta
	
	if loopAB > distAliceCharlie && duringAC <= 0.5:
		_calc_distAliceBob()
		Input.start_joy_vibration(0, distAliceBob, 0)
		duringAC += delta
	elif duringAC > 0.5 :
		Input.stop_joy_vibration(0)
		loopAB = 0
		duringAC = 0
	
	if loopBC > distBobPackage && duringBP <= 0.5 :
		_calc_distBobCharlie()
		Input.start_joy_vibration(1, 0.1+distBobCharlie, 0)
		duringBP += delta
	elif duringBP > 0.5 :
		Input.stop_joy_vibration(1)
		loopBC = 0
		duringBP = 0

# determine la frequence de vibration d'Alice
# lorsqu'elle se rapproche de Charlie, la frequence augmente
func _calc_distAliceCharlie():
	var dist = alice.get_global_pos().distance_to(charlie.get_global_pos())
	if dist >= 300 : 
		distAliceCharlie = 5
	else :
		distAliceCharlie = 5*dist/300

# determine l'intensité de vibration d'Alice
# lorsqu'elle se rapproche de Bob, l'intensité augmente
func _calc_distAliceBob():
	var dist = alice.get_global_pos().distance_to(bob.get_global_pos())
	if dist >= 300 : 
		distAliceBob = 1
	else :
		distAliceBob = dist/300

# determine l'intensité de vibration de Bob
# lorsqu'il se rapproche de Charlie, l'intensité augmente
func _calc_distBobCharlie():
	var dist = bob.get_global_pos().distance_to(charlie.get_global_pos())
	if dist >= 300 : 
		distBobCharlie = 0
	else :
		distBobCharlie = 1-0.9*dist/300

# determine la frequence de vibration de Bob
# lorsqu'il se rapproche du Paquet, la frequence augmente
func _calc_distBobPackage():
	var dist = bob.get_global_pos().distance_to(package.get_global_pos())
	if dist >= 300 : 
		distBobPackage = 6
	else :
		distBobPackage = 6*dist/300