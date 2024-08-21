extends TextureProgressBar

func _process(_delta: float) -> void:
	max_value = StatTracker.max_health
	value = StatTracker.health
