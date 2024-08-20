class_name AutoShootComponent extends Node2D

'''
automatically places bullets at its location, facing the direction in which the parent is facing
'''

@export var bulletscene : PackedScene
@export var base_cooldown : float = 1
@export var cooldown_variation : float = 0.5


@export_group("Projectile", "projectile")
@export var projectile_is_active : bool = true
@export var projectile_speed : float = 500
@export var projectile_lifetime : float = 2

@export_group("Damage", "damage")
@export var damage_is_active : bool = true
@export var damage_amount : float = 1
@export var damage_crit_chance : float = 0

var _cooldown_timer : Timer

func _ready():
	_cooldown_timer = Timer.new()
	call_deferred("add_child", _cooldown_timer)
	_cooldown_timer.timeout.connect(_shoot)
	_set_cooldown()
	_cooldown_timer.autostart = true

func _set_cooldown():
	_cooldown_timer.wait_time = base_cooldown + (randf()-0.5)*cooldown_variation

func _shoot():
	var bullet : Node2D = bulletscene.instantiate()
	bullet.position = global_position
	bullet.rotation = global_rotation
	_set_projectile_attributes(bullet)
	_set_damage_attributes(bullet)
	
	get_tree().root.add_child(bullet)
	_set_cooldown()

func _set_projectile_attributes(bullet : Node2D) -> void:
	if !projectile_is_active:
		return	
	var comp := _find_projectile_component(bullet)
	if comp == null:
		push_warning("bulletscene of '" + name + "' doesn't have a ProjectileComponent")
		return
	comp.speed = projectile_speed
	comp.lifetime = projectile_lifetime

func _find_projectile_component(bullet : Node) -> ProjectileComponent:
	for child in bullet.get_children():
		if child is ProjectileComponent:
			return child as ProjectileComponent
	return null

func _set_damage_attributes(bullet : Node2D) -> void:
	if !damage_is_active:
		return
	var comp := _find_damage_component(bullet)
	if comp == null:
		push_warning("bulletscene of '" + name + "' doesn't have a DamageComponent")
		return
	comp.damage = damage_amount
	comp.crit_chance = damage_crit_chance

func _find_damage_component(bullet : Node) -> DamageComponent:
	for child in bullet.get_children():
		if child is DamageComponent:
			return child as DamageComponent
	return null
