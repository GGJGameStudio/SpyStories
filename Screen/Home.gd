extends Node

func _ready():
	get_node("LinkButton").connect("pressed",self,"_on_button_pressed")
	#InputMap.action_add_event("click",InputEvent.JOYSTICK_BUTTON.
	set_process_input(true)

func _input(event):
	if event.type == InputEvent.JOYSTICK_BUTTON && event.button_index == 0:
		get_tree().change_scene("res://MainScene.tscn")


func _on_button_pressed():
	get_tree().change_scene("res://MainScene.tscn")
