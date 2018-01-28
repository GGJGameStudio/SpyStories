extends Node2D

var waiting = 0
var validation = false
var validation_duration = 0

func _ready():
	if global.language == "fr-fr":
		get_node("Header").set_text("Prenez la manette 1 si vous voulez jouer Alice <= ou Charlie =>")
		get_node("AliceLabel").set_text("Alice\nAime faire ses comptes, le thé\nN'aime pas le lapin blanc\nAlice cherche Bob dans la foule.\nElle est de moins en moins nerveuse à mesure qu'elle s'en approche (vibrations - intenses).\nElle détecte aussi Charlie ! Plus il est proche, plus ses vibrations sont fréquentes.\nVotre mission : donner son colis à Bob, puis l'aider à le poster ou à fuir avec.")
		get_node("CharlieLabel").set_text("Charlie\nAime l'odeur du napalm, le chocolat\nN'aime pas discuter\nCharlie doit intercepter le colis.\nPour mener à bien sa mission, il profite d'un mouchard sur l'équipement d'Alice.\nVotre mission : intercepter le colis, puis fuir avec (ou aider Erin à le faire).")
	else:
		get_node("Header").set_text("Take the 1st controller to play Alice <= or Charlie =>")
		get_node("AliceLabel").set_text("Alice\nLikes doing her accounting, tea\nDislikes the white rabbit\nAlice seeks Bob in the crowd.\nShe's less and less nervous as she's getting close to him (vibration lessers).\nShe also detects Charlie, vibrating more frequently when he's nearby.\nGoal: give the package to Bob, then help him posting it or running with it.")
		get_node("CharlieLabel").set_text("Charlie\nLikes napalm smell, chocolate\nDislikes conversation\nCharlie must intercept the parcel.\nTo do that, he's listening Alice's stuff.\nGoal: intercept the parcel and run with it (or help Erin to do so).")
	
	set_process(true)

func _process(delta):
	if waiting < 1:
		waiting += delta
	
	if validation:
		validation_duration += delta
	
	if validation_duration > 2:
		get_tree().change_scene("res://Screen/Controller2.tscn")
	
	if waiting > 1 && !validation:
		if Input.is_action_pressed("ui_accept"):
			get_node("Charlie/AnimatedSprite").set_animation("transfo")
			get_node("Alice/AnimatedSprite").set_animation("transfo")
			validation = true