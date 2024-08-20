extends Control

var is_shown : bool = false

func _ready():
	SceneManager.game_ended.connect(_show_screen)

func _show_screen():
	if is_shown:
		return
	is_shown = true
	$VBoxContainer/GameOverLabel/VBoxContainer/ScoreLabel.text = "Reached lvl: " + str(StatTracker.lvl)
	await get_tree().create_timer(1.5).timeout
	var animPlayer:AnimationPlayer = $AnimationPlayer
	animPlayer.play("fade_in")

func _on_restart_button_up():
	SceneManager.change_scene_to("res://main.tscn")

func _on_menu_button_up():
	SceneManager.change_scene_to("res://UI/Menu/main_menu.tscn")

func _on_quit_button_up():
	get_tree().quit()
