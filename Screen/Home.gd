extends Node

onready var french_flag = get_node("French")
onready var english_flag = get_node("English")

func _ready():
	get_node("LinkButton").connect("pressed",self,"_on_button_pressed")
	get_node("LanguageRight").connect("pressed", self, "_change_language")
	get_node("LanguageLeft").connect("pressed", self, "_change_language")
	set_process_input(true)

func _input(event):
	if event.type == InputEvent.JOYSTICK_BUTTON && event.pressed && event.button_index == 0:
		validate_language()
	if event.type == InputEvent.JOYSTICK_BUTTON && event.pressed && (event.button_index == 14 || event.button_index == 15):
		_change_language()

func _on_button_pressed():
	validate_language()

func validate_language():
	global.language = "fr-fr" if french_flag.is_visible() else "en-uk"
	get_tree().change_scene("res://Screen/Controller1.tscn")

func _change_language():
	if french_flag.is_visible():
		french_flag.hide()
		english_flag.show()
	else:
		french_flag.show()
		english_flag.hide()