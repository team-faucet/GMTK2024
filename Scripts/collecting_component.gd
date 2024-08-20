class_name CollectingComponent extends Area2D

func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		hitbox.hit(null)
