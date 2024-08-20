extends Label


func _ready():
	StatTracker.enemy_killed.connect(_on_stat_update)
	StatTracker.gained_xp.connect(_on_stat_update)
	text = "Kills: 0\nXP: 0"

func _on_stat_update():
	text = "Kills: " + str(StatTracker.enemies_killed) + "\nXP: " + str(StatTracker.xp)
