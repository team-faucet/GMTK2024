extends Control


var is_paused = false


func _ready():
	SceneManager.toggle_pause.connect(_on_toggle_pause)
	

func _on_toggle_pause():
	is_paused = !is_paused
	visible = is_paused
	get_tree().paused = is_paused



func _on_resume_button_button_up():
	is_paused = false
	visible = false
	get_tree().paused = false

func _on_menu_button_button_up():
	SceneManager.change_scene_to("res://UI/Menu/main_menu.tscn")

func _on_quit_button_button_up():
	get_tree().quit()
