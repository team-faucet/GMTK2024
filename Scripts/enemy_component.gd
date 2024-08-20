extends Node2D

@export var xp_scene : PackedScene
@export var food_scene : PackedScene

@export_range(0, 100, 1, 'or_greater') var min_xp : int = 1
@export_range(0, 100, 1, 'or_greater') var max_xp : int = 5

func _ready():
	for sibling in get_parent().get_children():
		if sibling is HealthComponent:
			var healthcomp : HealthComponent = sibling
			healthcomp.died.connect(_on_health_comp_died)

func spawn_xp() -> void:
	var xp : XP = xp_scene.instantiate()
	xp.global_position = global_position + 10 * Vector2(2. * randf() - 1., 2. * randf() - 1.)
	xp.value = randi_range(min_xp, max_xp)
	get_tree().root.call_deferred('add_child', xp)
	
func spawn_food() -> void:
	var food : Food = food_scene.instantiate()
	food.global_position = global_position + 10 * Vector2(2. * randf() - 1., 2. * randf() - 1.)
	get_tree().root.call_deferred('add_child', food)

func _on_health_comp_died():
	StatTracker.kill_enemy()
	spawn_xp()
	if (randf() < 1/8.):
		spawn_food()
