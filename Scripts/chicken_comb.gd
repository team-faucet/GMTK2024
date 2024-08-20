class_name ChickenComb extends Node2D


func _ready():
	var tween : Tween = get_tree().create_tween().bind_node(get_node("."))
	tween.tween_property(get_node("."), "scale", Vector2.ZERO, 2)
	tween.tween_callback(queue_free)
