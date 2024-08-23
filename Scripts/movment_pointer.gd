extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "rotation", PI/2 + $"..".player.move_dir.angle_to(Vector2.UP), 0.1)
	# rotation = PI/2 + $"..".player.move_dir.angle_to(Vector2.UP)
