extends Node2D

func _ready():
	get_node("LinkButton").connect("pressed",self,"_on_button_pressed")
	set_process_input(true)

func _input(event):
	if event.type == InputEvent.JOYSTICK_BUTTON && event.pressed && event.button_index == 0:
		get_tree().change_scene("res://Screen/Controller1.tscn")
		
func _on_button_pressed():
	get_tree().change_scene("res://Screen/Controller1.tscn")