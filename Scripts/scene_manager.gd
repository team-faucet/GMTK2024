extends Node

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

func _input(event):
	if event.is_action("ui_cancel"):
		get_tree().quit()
