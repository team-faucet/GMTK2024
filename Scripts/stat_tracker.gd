extends Node

signal enemy_killed

var enemies_killed : int = 0

func _ready():
	enemy_killed.connect(_on_enemy_killed)


func _on_enemy_killed():
	enemies_killed += 1
	
