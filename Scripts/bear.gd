class_name Bear extends Enemy


func _on_health_component_died():
	queue_free()
