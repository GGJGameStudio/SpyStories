extends Node2D

var waiting = 0
var validation = false
var validation_duration = 0

func _ready():
	if global.language == "fr-fr":
		get_node("Header").set_text("Prenez la manette 2 si vous voulez jouer Bob <= ou Erin =>")
		get_node("ErinLabel").set_text("Erin\nAime le sirop de menthe, la vitesse\nN'aime pas le bruit\n\nErin doit intercepter le colis. Elle profite\nd'un mouchard sur l'équipement de Bob,\net d'un kit de furtivité : elle est\nindétectable pour Alice comme pour Bob.\n\nVotre mission : intercepter le colis,\npuis fuir avec (ou aider Charlie à le faire).")
		get_node("BobLabel").set_text("Bob\n\nAime Jean-Michel Jam, les trésors enfouis\nN'aime pas le matin\n\nBob possède un détecteur de colis, qui vibre de\nplus en plus souvent à mesure qu'il s'en rapproche.\nIl est de plus en plus nerveux à mesure que\nCharlie s'approche du colis (vibrations + intenses).\n\nVotre mission : récupérer le colis\npuis le poster ou fuir avec.")
	else:
		get_node("Header").set_text("Take the 2nd controller to play Bob <= or Erin =>")
		get_node("ErinLabel").set_text("Likes mint syrup, speed\nDislikes noise\n\nErin must intercept the parcel.\nTo do that, she's listening Bob's stuff.\nShe's using a stealth kit, making\nher undetectable for Alice and Bob.\n\nGoal: intercept the parcel\nand run with it (or help Charlie to do so).")
		get_node("BobLabel").set_text("Likes Jon-Michael Confiture, buried treasures\nDislikes the morning\n\nBob has a parcel detector, vibrating\nmore frequently as he's getting close.\nHe's more and more nervous as Charlie's\ngetting close to the parcel (vibration intensifies).\n\nGoal: get the parcel and post it or flee with it.")
	
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