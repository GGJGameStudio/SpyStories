extends Area2D

func _on_Area2D_body_enter( body ):
	if body.is_in_group("package") && body.get_parent() != get_parent().get_node("YSort_Spawn/Alice"):
		get_tree().change_scene("res://Screen/Home.tscn")
