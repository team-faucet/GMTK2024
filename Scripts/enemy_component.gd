extends Node2D

@export_group("XP Drop", "xp_")
@export var xp_scene : PackedScene
@export_range(0, 100, 1, 'or_greater') var xp_gain_min : int = 1
@export_range(0, 100, 1, 'or_greater') var xp_gain_max : int = 5

@export_group("Food Drop", "food_")
@export var food_scene : PackedScene
@export_range(0, 100, 1, 'or_greater') var food_hp_gain_min : float = 1
@export_range(0, 100, 1, 'or_greater') var food_hp_gain_max : float = 5
@export_range(0, 1) var food_spawn_chance : float = 0.15

func _ready():
	for sibling in get_parent().get_children():
		if sibling is HealthComponent:
			var healthcomp : HealthComponent = sibling
			healthcomp.died.connect(_on_health_comp_died)

func spawn_xp() -> void:
	var xp : XP = xp_scene.instantiate()
	xp.global_position = global_position + 30 * randf() * Vector2.from_angle(2*PI*randf())
	xp.value = randi_range(xp_gain_min, xp_gain_max)
	get_tree().root.call_deferred('add_child', xp)
	
func spawn_food() -> void:
	var food : Food = food_scene.instantiate()
	food.global_position = global_position + 30 * randf() * Vector2.from_angle(2*PI*randf())
	food.heal = randf_range(food_hp_gain_min, food_hp_gain_max)
	get_tree().root.call_deferred('add_child', food)

func _on_health_comp_died():
	StatTracker.kill_enemy()
	spawn_xp()
	if (randf() < food_spawn_chance):
		spawn_food()
