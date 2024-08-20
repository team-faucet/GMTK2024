extends TextureProgressBar

func _process(delta: float) -> void:
	max_value = StatTracker.max_health
	value = StatTracker.health
