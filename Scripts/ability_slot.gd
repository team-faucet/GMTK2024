class_name AbilitySlot extends Node2D


@export var ability_scene : PackedScene
@export_range(1, 2) var action_num : int = 1
@export var set_ability_rotation : bool = false
@export_range(0, 20, 0.1, "or_greater") var cooldown_time : float = 1

var action_name : String
var is_on_cooldown : bool = false
var cooldown_timer : Timer

func _ready():
	action_name = "game_act" + str(action_num)
	cooldown_timer = Timer.new()
	cooldown_timer.one_shot = false
	cooldown_timer.timeout.connect(func(): is_on_cooldown = false)
	call_deferred("add_child", cooldown_timer)

func _process(_delta):
	if Input.is_action_just_pressed(action_name):
		try_use_ability()
	

func try_use_ability():
	if is_on_cooldown:
		return
	
	var ability : Node2D = ability_scene.instantiate()
	ability.global_position = global_position
	if set_ability_rotation:
		ability.rotation = global_rotation
	get_tree().current_scene.call_deferred("add_child", ability)
	is_on_cooldown = true
	cooldown_timer.start(cooldown_time)
