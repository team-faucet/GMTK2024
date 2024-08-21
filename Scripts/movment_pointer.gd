extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation = PI/2 + $"..".player.move_dir.angle_to(Vector2.UP)
