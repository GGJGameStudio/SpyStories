extends RigidBody2D

func _ready():
	add_to_group("package")
	set_fixed_process(true)

func _fixed_process(delta):
	set_global_pos(get_parent().get_parent().get_global_pos())
