class_name DamageComponent extends Area2D

signal hit

@export var damage : float = 1
@export_range(0,1) var crit_chance:float = 0

var damage_info : DamageInfo

func _ready():
	damage_info = DamageInfo.new(damage, crit_chance)


func _on_area_entered(area):
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		hitbox.hit(damage_info)
		hit.emit()
