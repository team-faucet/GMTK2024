class_name HealthComponent extends Node2D

signal health_changed
signal damage_taken(amount : float, is_crit : bool)
signal died

@export var health : float = 100

var _alive:bool = true

@export var show_damage_number : bool = true

@export var delete_on_death : bool = false

func take_damage(damage_info : DamageInfo) -> float:
	var hit_info = _calculate_actual_damage(damage_info)
	var amount : float = hit_info[0]
	var is_crit : bool = hit_info[1]
	if !_alive:
		return 0
	var damage_dealt = min(health, amount)
	health -= amount
	damage_taken.emit(damage_dealt, is_crit)
	health_changed.emit()
	
	if health <= 0:
		_die()
	
	_show_damage_number(damage_dealt, is_crit)
	return damage_dealt

func _die():
	if delete_on_death:
		get_parent().queue_free()
	_alive = false
	died.emit()

func _calculate_actual_damage(damage_info : DamageInfo) -> Array:
	var actual_damage : float = damage_info.basedamage
	var is_crit : bool = false
	if randf() < damage_info.crit_chance:
		is_crit = true
		actual_damage = 2 * damage_info.basedamage
	return [actual_damage, is_crit]

func _show_damage_number(damage : float, is_crit : bool):
	if !show_damage_number:
		return
	
	var damage_int := roundi(damage)
	
	var label := Label.new()
	label.global_position = global_position
	label.text = str(abs(damage_int))
	label.z_index = 5
	label.label_settings = LabelSettings.new()
	
	var color = "#FFF"
	var font_size:int = 30
	if is_crit:
		color = "FF2020"
		font_size = int(font_size * 1.5)
	elif damage < 0.:
		color = "#0F0"
		label.text = "+" + label.text
	
	label.label_settings.font_color = color
	label.label_settings.font_size = font_size
	label.label_settings.outline_color = "#000"
	label.label_settings.outline_size = 20
	
	get_tree().current_scene.call_deferred("add_child", label)
	
	await label.resized
	label.pivot_offset = Vector2(label.size / 2)
	label.scale *= 0.5
	
	var tween = get_tree().create_tween()
	tween.set_parallel(true).bind_node(label).tween_callback(label.queue_free).set_delay(0.4)
	tween.tween_property(label, "scale", 2*label.scale, 0.2).set_ease(Tween.EASE_OUT)
	tween.tween_property(label, "scale", Vector2.ZERO, 0.2).set_delay(0.3).set_ease(Tween.EASE_IN)
	tween.tween_property(label, "position:y", label.position.y-80, 0.5)
	var rand_delta_x : float = 20*2*(randf()-0.5)
	tween.tween_property(label, "position:x", label.position.x+rand_delta_x, 0.5)
	
