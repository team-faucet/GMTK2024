class_name ProjectileComponent extends Node


@export var speed : float = 500
@export var lifetime : float = 1
var parent:Node2D


func _ready():
	parent = get_parent()
	if parent == null:
		push_error(scene_file_path + ":8 - Parent of '" + name + "' is null!")
	var timer := Timer.new()
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(func(): parent.call_deferred("queue_free"))
	if lifetime != -1:
		timer.start(lifetime)

func _process(delta):
	parent.position += Vector2.from_angle(parent.rotation-PI/2)*speed*delta
