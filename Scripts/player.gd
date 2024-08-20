class_name Player extends Node2D


@export var speed = 400

@export var shot_scene : PackedScene
@export var shot_position : Node2D
@export var mine_scene : PackedScene

func _process(delta):
	var input := Input.get_vector("ui_left", "ui_right", "ui_up","ui_down")
	position += input*speed*delta
	rotation = -(get_viewport().get_mouse_position()-0.5*get_viewport_rect().size).angle_to(Vector2.UP)
	if Input.is_action_just_pressed("game_act1"):
		action1()
	if Input.is_action_just_pressed("game_act2"):
		action2()

func action1():
	var shot : Node2D = shot_scene.instantiate()
	shot.global_position = global_position
	shot.rotation = rotation
	get_tree().current_scene.call_deferred("add_child", shot)

func action2():
	var mine : Node2D = mine_scene.instantiate()
	mine.global_position = global_position
	get_tree().current_scene.call_deferred("add_child", mine)
	
