extends Control

func _on_play_button_button_up():
	SceneManager.change_scene_to("res://main.tscn")
	

func _on_quit_button_button_up():
	get_tree().quit()
