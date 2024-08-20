extends Node

@export var player : Player

@export_group("Enemy Spawning")
@export var time_to_spawn : float = 1
@export var enemy_scenes : Array[PackedScene]
@export var spawn_distance_to_screen : int = 40


var timer:Timer

func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(spawn_enemy)
	timer.start(time_to_spawn)


func spawn_enemy():
	var enemy_scene:PackedScene = enemy_scenes[randi_range(0,len(enemy_scenes)-1)]
	var enemy:Enemy = enemy_scene.instantiate()
	_set_player_field(enemy)
	enemy.position = _get_random_position()
	get_tree().root.add_child(enemy)
	timer.start(time_to_spawn)

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
	
