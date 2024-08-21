class_name Food extends Node2D

var heal : float = 1

func _ready():
	$DamageComponent.hit.connect(queue_free)
	$DamageComponent.damage_info.basedamage = -heal
	
