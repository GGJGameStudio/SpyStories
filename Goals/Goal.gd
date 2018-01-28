extends Area2D

func _on_Area2D_body_enter( body ):
	var name = get_name()
	var package = body.is_in_group("package")
	var pj = body.get_parent().get_parent()
	if name == "PostBox" && package && pj.is_in_group("cia_could_win"):
		global.winner = "cia"
		get_tree().change_scene("res://Screen/End.tscn")
	if (name=="Exit1" || name=="Exit2") && package && (pj.is_in_group("cia_could_win") || pj.is_in_group("kgb_could_win")):
		if pj.is_in_group("cia_could_win") : 
			global.winner = "cia"
		else :
			global.winner = "kgb"
		get_tree().change_scene("res://Screen/End.tscn")
