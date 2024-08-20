class_name XP extends Node2D

var value : int = 1

func _on_hitbox_component_is_hit() -> void:
	StatTracker.gain_xp(value)
	queue_free()
