extends Node

func _ready():
    get_node("LinkButton").connect("pressed",self,"_on_button_pressed")

func _on_button_pressed():
    get_tree().change_scene("res://MainScene.tscn")