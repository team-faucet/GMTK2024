class_name Mine extends Node2D

var currently_expanding : bool = false
var explosion_time : float = 0.3
var max_scale : float = 6

func _on_damage_component_hit():
	if !currently_expanding:
		currently_expanding = true
		var tween : Tween = get_tree().create_tween().bind_node(get_node(".")).set_parallel(true)
		tween.tween_property(get_node("."), "scale", max_scale*scale, explosion_time)
		tween.tween_property(get_node("."), "modulate", Color.from_string("#ff7766", Color.BLACK), 0.5*explosion_time)
		tween.tween_callback(queue_free).set_delay(explosion_time)
