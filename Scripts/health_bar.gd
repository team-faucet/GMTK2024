extends TextureProgressBar

func _ready():
	StatTracker.health_changed.connect(_update)
	_update()

func _update():
	max_value = StatTracker.max_health
	value = StatTracker.health
