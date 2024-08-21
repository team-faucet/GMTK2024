class_name Player extends CharacterBody2D

@export var speed = 400

var move_dir : Vector2 = Vector2.UP

func _ready() -> void:
	StatTracker.max_health = $HealthComponent.health
	StatTracker.health = $HealthComponent.health

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation = -(get_viewport().get_mouse_position()-0.5*get_viewport_rect().size).angle_to(Vector2.UP)
	
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction.normalized() * speed
		move_dir = Vector2(direction.x, -direction.y)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.y = move_toward(velocity.y, 0, speed)
	
	move_and_slide()

func _on_health_component_died():
	SceneManager.game_ended.emit()
	process_mode = PROCESS_MODE_DISABLED

func _on_health_component_health_changed() -> void:
	StatTracker.health = $HealthComponent.health
