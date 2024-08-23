class_name DamageComponent extends Area2D

signal hit

@export var damage: float = 1
@export_range(0,1) var crit_chance: float = 0
@export_range(0, 10, .05, "or_greater") var tick: float = 0

var damage_info: DamageInfo
var entered: Array[HitboxComponent]

func _ready():
	damage_info = DamageInfo.new(damage, crit_chance)
	if tick:
		$Timer.set_wait_time(tick)
		$Timer.start()

func _deal_damage(hitbox: HitboxComponent) -> void:
	hitbox.hit(damage_info)
	hit.emit()

func _on_area_entered(area: Area2D) -> void:
	if (area is HitboxComponent):
		entered.append(area)
		if not tick:
			_deal_damage(area)

func _on_area_exited(area: Area2D) -> void:
	entered.erase(area)

func _on_timer_timeout() -> void:
	for hitbox in entered:
		_deal_damage(hitbox)
