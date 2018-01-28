extends Area2D

export(bool) var spawns
export(String, "Up", "Down", "Right", "Left") var spawn_direction

func _ready():
	var spawn = get_node("Spawner")
	
	spawn.spawning = spawns
	
	if spawns:
		if spawn_direction == "Up":
			spawn.initial_direction = Vector2(0,-1)
		elif spawn_direction == "Down":
			spawn.initial_direction = Vector2(0,1)
		elif spawn_direction == "Right":
			spawn.initial_direction = Vector2(1,0)
		elif spawn_direction == "Left":
			spawn.initial_direction = Vector2(-1,0)
	
		spawn.initial_duration = 4
		spawn.spawn_interval = rand_range(1, 4)

func _on_Area2D_body_enter( body ):
	var name = get_name()
	var pj = body.get_parent()
	var package = (pj == global.owner)
	if name == "PostBox" && package && pj.is_in_group("cia_could_win"):
		global.winner = "cia"
		get_tree().change_scene("res://Screen/End.tscn")
	if (name=="Exit1" || name=="Exit2") && package && (pj.is_in_group("cia_could_win") || pj.is_in_group("kgb_could_win")):
		if pj.is_in_group("cia_could_win") : 
			global.winner = "cia"
		else :
			global.winner = "kgb"
		get_tree().change_scene("res://Screen/End.tscn")
