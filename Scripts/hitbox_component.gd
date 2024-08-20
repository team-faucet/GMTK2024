class_name HitboxComponent extends Area2D


@export var health_comp : HealthComponent


func _ready():
	if health_comp == null:
		push_warning("HealthComponent for '" + name + "' is not initialized!")

func hit(damage_info : DamageInfo) -> void:
	_damage(damage_info)

func _damage(damage_info:DamageInfo) -> void:
	if health_comp:
		health_comp.take_damage(damage_info)
