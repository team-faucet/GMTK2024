extends Node2D



func _on_damage_component_hit():
	queue_free()
