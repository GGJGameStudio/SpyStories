extends Node

var packageScene = load("res://Package/Package.tscn")

onready var alice = get_node("YSort/Alice")
onready var charlie = get_node("YSort/Charlie")
onready var bob = get_node("YSort/Bob")
onready var erin = get_node("YSort/Erin")

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
	
	get_node("CalmTheme").set_loop(true)
	get_node("CalmTheme").play()
	
	get_node("Train1/AnimatedSprite").play()
	get_node("Train2/AnimatedSprite").play()
	
	set_process(true)
	
func _process(delta):
	pass
