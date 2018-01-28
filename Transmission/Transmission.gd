extends Node

var alice
var bob
var charlie
var erin

var cia
var kgb

var dist_action = 222

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
		var dist_cia = (alice_or_bob.get_global_pos() - other_cia.get_global_pos()).length()
		if alice_or_bob == global.owner && dist_cia < dist_action && alice_or_bob.get_node("BuddySprite").is_acting:
			global.owner = other_cia
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
			var dist_kgb = (charlie_or_erin.get_global_pos() - other_kgb.get_global_pos()).length()
			if charlie_or_erin == global.owner && dist_kgb < dist_action && charlie_or_erin.get_node("BuddySprite").is_acting:
				global.owner = other_kgb
				if charlie==charlie_or_erin:
					Input.start_joy_vibration(1, 0, 1, 1)
				else:
					Input.start_joy_vibration(0, 0, 1, 1)
			
			# on gere le vol de colis
			var dist_cia_kgb = (alice_or_bob.get_global_pos() - charlie_or_erin.get_global_pos()).length()
			# le kgb vole a la cia
			if alice_or_bob == global.owner && dist_cia_kgb < dist_action && charlie_or_erin.get_node("BuddySprite").is_acting:
				global.owner = charlie_or_erin
				if alice==alice_or_bob:
					Input.start_joy_vibration(0, 0, 1, 1)
				else:
					Input.start_joy_vibration(1, 0, 1, 1)
				alice_or_bob.set_paralyze()
			# la cia vole au kgb
			if charlie_or_erin == global.owner && dist_cia_kgb < dist_action && alice_or_bob.get_node("BuddySprite").is_acting:
				global.owner = alice_or_bob
				if charlie==charlie_or_erin:
					Input.start_joy_vibration(0, 0, 1, 1)
				else:
					Input.start_joy_vibration(1, 0, 1, 1)
				charlie_or_erin.set_paralyze()
