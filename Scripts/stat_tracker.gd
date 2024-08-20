extends Node

signal enemy_killed
signal gained_xp

var enemies_killed : int = 0

var xp : int = 0
var lvl : int = 1

func kill_enemy():
	enemies_killed += 1
	enemy_killed.emit()

func gain_xp(xp_in : int) -> void:
	xp += xp_in
	if (lvl >= 0):
		lvl = floor(sqrt(xp))
	gained_xp.emit()
