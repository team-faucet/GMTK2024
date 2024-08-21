extends Node

@warning_ignore("unused_signal")
signal game_ended
signal toggle_pause

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	process_mode = PROCESS_MODE_ALWAYS

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause.emit()
	elif event.is_action_pressed("reset"):
		get_tree().paused = false
		change_scene_to("res://UI/Menu/main_menu.tscn")

func change_scene_to(scene_path):
	get_tree().call_deferred("change_scene_to_file", scene_path)
