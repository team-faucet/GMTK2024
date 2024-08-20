class_name FollowPlayerComponent extends Node


@export var follow_player : bool = true
@export var follow_force : float = 100
@export var lookat_player : bool = true
@export var rotation_force : float = 4000

# has to be initialized from outside
var player : Node2D

# will be initialized inside
var parent : RigidBody2D

func _ready():
	parent = get_parent()


func _physics_process(_delta):
	if follow_player:
		var deltapos = player.position - parent.position
		var direction = deltapos.normalized()
		var force : Vector2 = follow_force*direction
		parent.apply_central_force(force)
	
	if lookat_player:
		var deltapos = player.position - parent.position
		var angle_dir = sign(Vector2.from_angle(parent.rotation - PI/2).angle_to(deltapos))
		parent.apply_torque(angle_dir * rotation_force)
