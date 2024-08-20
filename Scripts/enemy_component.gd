extends Node2D


func _ready():
	for sibling in get_parent().get_children():
		if sibling is HealthComponent:
			var healthcomp : HealthComponent = sibling
			healthcomp.died.connect(_on_health_comp_died)


func _on_health_comp_died():
	StatTracker.enemy_killed.emit()
