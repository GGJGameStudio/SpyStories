extends Node2D

var waiting = 0
var validation = false
var validation_duration = 0

func _ready():
	if global.language == "fr-fr":
		get_node("Header").set_text("Prenez la manette 2 si vous voulez jouer Bob <= ou Erin =>")
		get_node("ErinLabel").set_text("Erin\nAime le sirop de menthe, la vitesse\nN'aime pas le bruit\nErin doit intercepter le colis. Elle profite d'un mouchard sur l'équipement de Bob,\net d'un kit de furtivité : elle est indétectable pour Alice comme pour Bob.\nVotre mission : intercepter le colis, puis fuir avec (ou aider Charlie à le faire).")
		get_node("BobLabel").set_text("Bob\n\nAime Jean-Michel Jam, les trésors enfouis\nN'aime pas le matin\nBob possède un détecteur de colis, qui vibre de plus en plus souvent à mesure qu'il s'en rapproche.\nIl est de plus en plus nerveux à mesure que Charlie s'approche du colis (vibrations + intenses).\nVotre mission : récupérer le colis puis le poster ou fuir avec.")
	else:
		get_node("Header").set_text("Take the 2nd controller to play Bob <= or Erin =>")
		get_node("ErinLabel").set_text("Likes mint syrup, speed\nDislikes noise\nErin must intercept the parcel. To do that, she's listening Bob's stuff. She's using a stealth kit, making her undetectable for Alice and Bob.\nGoal: intercept the parcel and run with it (or help Charlie to do so).")
		get_node("BobLabel").set_text("Likes Jon-Michael Confiture, buried treasures\nDislikes the morning\nBob has a parcel detector, vibrating more frequently as he's getting close.\nHe's more and more nervous as Charlie's getting close to the parcel (vibration intensifies).\nGoal: get the parcel and post it or flee with it.")
	
	set_process(true)

func _process(delta):
	if waiting < 1:
		waiting += delta
	
	if validation:
		validation_duration += delta
	
	if validation_duration > 2:
		get_tree().change_scene("res://MainScene.tscn")
	
	if waiting > 1 && !validation:
		if Input.is_action_pressed("ui_accept"):
			get_node("Bob/AnimatedSprite").set_animation("transfo")
			get_node("Erin/AnimatedSprite").set_animation("transfo")
			validation = true