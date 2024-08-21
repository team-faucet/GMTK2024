extends Node

@export var player : Player

@export_group("Enemy Spawning")
@export var base_spawn_rate : float = 0.5
@export var spawn_rate_increase : float = 0.1
@export var enemy_count_max : int = 100
@export var enemy_scenes : Array[PackedScene]
@export var spawn_distance_to_screen : int = 40


var timer:Timer
@onready var current_spawn_rate : float = base_spawn_rate
var enemy_count_current : int = 0

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(try_spawn_enemy)
	timer.start(1/current_spawn_rate)
	StatTracker.enemy_killed.connect(func(): enemy_count_current -= 1)

func _process(delta):
	current_spawn_rate += spawn_rate_increase * delta

func try_spawn_enemy():
	if enemy_count_current >= enemy_count_max:
		return
	enemy_count_current += 1
	var enemy_scene:PackedScene = enemy_scenes[0]
	if randf() < 0.25:
		enemy_scene = enemy_scenes[1]
	var enemy:Enemy = enemy_scene.instantiate()
	_set_player_field(enemy)
	enemy.position = _get_random_position()
	get_tree().current_scene.add_child(enemy)
	timer.start(1/current_spawn_rate)

func _set_player_field(enemy : Enemy) -> void:
	for child in enemy.get_children():
		if child is FollowPlayerComponent:
			child.player = player

func _get_random_position() -> Vector2:
	var cam_pos : Vector2 = get_viewport().get_camera_2d().global_position
	var fov_size : Vector2 = Vector2(get_viewport().size) / get_viewport().get_camera_2d().zoom
	var min_distance : float = 0.5 * fov_size.length() + spawn_distance_to_screen
	var randangle = randf() * 2 * PI
	var spawn_pos := min_distance * Vector2.from_angle(randangle) + cam_pos
	return spawn_pos
	
