class_name ChickenComb extends Node2D

func _ready():
	var lifetime = $ProjectileComponent.lifetime
	var tween : Tween = get_tree().create_tween().bind_node(get_node("."))
	tween.tween_property(get_node("."), "scale", 0.2*scale, lifetime)
	tween.tween_callback(queue_free)


func _on_damage_component_body_entered(body: Node2D) -> void:
	if body is StaticBody2D:
		queue_free()
