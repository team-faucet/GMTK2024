class_name HitboxComponent extends Area2D


@export var health_comp : HealthComponent


func _ready():
	if health_comp == null:
		for comp in get_parent().get_children():
			if comp is HealthComponent:
				health_comp = comp
		push_warning("HealthComponent for '" + name + "' is not initialized!")

func hit(damage_info : DamageInfo) -> void:
	if health_comp:
		health_comp.take_damage(damage_info)
