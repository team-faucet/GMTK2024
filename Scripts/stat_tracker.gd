extends Node

signal enemy_killed
signal gained_xp
signal lvled_up
signal health_changed

var enemies_killed : int = 0

var lvl : int = 1

var total_xp : int = 0
var xp_curr : int = 0
var xp_next : int = get_next_xp()

var max_health: float
var health: float

func set_health(health_new : float) -> void:
	health = health_new
	health_changed.emit()

func kill_enemy():
	enemies_killed += 1
	enemy_killed.emit()

func gain_xp(xp_in : int) -> void:
	xp_curr += xp_in
	total_xp += xp_in
	if (xp_curr >= xp_next):
		lvl += 1
		xp_curr = 0
		xp_next = get_next_xp()
		lvled_up.emit()
	gained_xp.emit()


func get_next_xp() -> int:
	return int(10 * sqrt(lvl))
