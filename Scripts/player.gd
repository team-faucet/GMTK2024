class_name Player extends Node2D

@export var speed = 400

var move_dir : Vector2 = Vector2.UP

func _ready() -> void:
	StatTracker.max_health = $HealthComponent.health
	StatTracker.health = $HealthComponent.health

func _process(delta):
	var input := Input.get_vector("ui_left", "ui_right", "ui_up","ui_down")
	if input.length() > 0:
		move_dir = Vector2(input.x, -input.y)
	position += input*speed*delta
	rotation = -(get_viewport().get_mouse_position()-0.5*get_viewport_rect().size).angle_to(Vector2.UP)

func _on_health_component_health_changed() -> void:
	StatTracker.health = $HealthComponent.health
