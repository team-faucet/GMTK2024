extends Node

signal enemy_killed
signal gained_xp
signal lvled_up

var enemies_killed : int = 0

var lvl : int = 1

var total_xp : int = 0
var xp_curr : int = 0
var xp_next : int = get_next_xp()

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
