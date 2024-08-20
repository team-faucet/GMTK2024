class_name Player extends Node2D


@export var speed = 400

func _process(delta):
	var input := Input.get_vector("ui_left", "ui_right", "ui_up","ui_down")
	position += input*speed*delta
	rotation = -(get_viewport().get_mouse_position()-0.5*get_viewport_rect().size).angle_to(Vector2.UP)
