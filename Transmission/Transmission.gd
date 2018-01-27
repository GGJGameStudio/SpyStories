extends Node

var alice
var bob
var charlie
var erin
var package

var cia
var kgb

func _ready():
	set_process(true)

func _process(delta):
	for alice_or_bob in cia :
		# on gere le passage de paquet entre les agents de la cia
		var other_cia
		if alice==alice_or_bob:
			other_cia = bob
		else:
			other_cia = alice
		var dist_cia = (alice_or_bob.get_pos() - other_cia.get_pos()).length()
		if alice_or_bob.is_a_parent_of(package) && dist_cia < 50 && alice_or_bob.get_node("BuddySprite").last_move == alice_or_bob.get_node("BuddySprite").Action.Acting:
			alice_or_bob.remove_child(package)
			other_cia.add_child(package)
			if alice==alice_or_bob:
				Input.start_joy_vibration(1, 0, 1, 1)
			else:
				Input.start_joy_vibration(0, 0, 1, 1)
		
		# on gere le passage de paquet entre les agents du kgb
		for charlie_or_erin in kgb:
			var other_kgb
			if charlie==charlie_or_erin:
				other_kgb = erin
			else:
				other_kgb = charlie
			var dist_kgb = (charlie_or_erin.get_pos() - other_kgb.get_pos()).length()
			if charlie_or_erin.is_a_parent_of(package) && dist_kgb < 50 && charlie_or_erin.get_node("BuddySprite").last_move == charlie_or_erin.get_node("BuddySprite").Action.Acting:
				charlie_or_erin.remove_child(package)
				other_kgb.add_child(package)
				if charlie==charlie_or_erin:
					Input.start_joy_vibration(1, 0, 1, 1)
				else:
					Input.start_joy_vibration(0, 0, 1, 1)
			
			# on gere le vol de colis
			var dist_cia_kgb = (alice_or_bob.get_pos() - charlie_or_erin.get_pos()).length()
			# le kgb vole a la cia
			if alice_or_bob.is_a_parent_of(package) && dist_cia_kgb < 50 && charlie_or_erin.get_node("BuddySprite").last_move == charlie_or_erin.get_node("BuddySprite").Action.Acting:
				alice_or_bob.remove_child(package)
				charlie_or_erin.add_child(package)
				if alice==alice_or_bob:
					Input.start_joy_vibration(0, 0, 1, 1)
				else:
					Input.start_joy_vibration(1, 0, 1, 1)
				alice_or_bob.paralyzed = true
			# la cia vole au kgb
			if charlie_or_erin.is_a_parent_of(package) && dist_cia_kgb < 50 && alice_or_bob.get_node("BuddySprite").last_move == alice_or_bob.get_node("BuddySprite").Action.Acting:
				charlie_or_erin.remove_child(package)
				alice_or_bob.add_child(package)
				if charlie==charlie_or_erin:
					Input.start_joy_vibration(0, 0, 1, 1)
				else:
					Input.start_joy_vibration(1, 0, 1, 1)
				charlie_or_erin.paralyzed = true
