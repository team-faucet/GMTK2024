class_name Food extends Node2D

@export var min_regen : float = 1.
@export var max_regen : float = 5.

func _ready():
	$DamageComponent.hit.connect(func(): queue_free())
	$DamageComponent.damage_info.basedamage = -randf_range(min_regen, max_regen)
