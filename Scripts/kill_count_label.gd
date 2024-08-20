extends Label


func _ready():
	StatTracker.enemy_killed.connect(_on_enemy_killed)
	text = "Kills: 0"

func _on_enemy_killed():
	text = "Kills: " + str(StatTracker.enemies_killed)
