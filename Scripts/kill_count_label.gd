extends Label


func _ready():
	StatTracker.enemy_killed.connect(_on_stat_update)
	StatTracker.gained_xp.connect(_on_stat_update)
	text = "LVL 1"

func _on_stat_update():
	text = "LVL " + str(StatTracker.lvl)
