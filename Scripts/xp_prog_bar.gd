extends TextureProgressBar


func _process(_delta: float) -> void:
	max_value = StatTracker.xp_next
	value = StatTracker.xp_curr
