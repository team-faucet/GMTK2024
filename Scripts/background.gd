extends Node2D

@export var player : Player

@export var texture : Texture2D
@export var texture_scale : float = 1

var center : Vector2
var sprite_size : Vector2
var background_sprites : Array[Sprite2D] = []


func _ready():
	center = get_viewport().get_camera_2d().global_position
	sprite_size = texture_scale*texture.get_size()
	_init_sprites()

func _process(_delta):
	_rearrange_sprites()

func _init_sprites():
	var view_size : Vector2 =  Vector2(get_viewport_rect().size) / get_viewport().get_camera_2d().zoom
	var num_sprites_x : int = ceil(view_size.x/sprite_size.x) + 2
	var num_sprites_y : int = ceil(view_size.y/sprite_size.y) + 2
	if num_sprites_x%2 == 0:
		num_sprites_x += 1
	if num_sprites_y%2 == 0:
		num_sprites_y += 1
	
	for x : int in range(num_sprites_x):
		for y : int in range(num_sprites_y):
			var sprite : Sprite2D = Sprite2D.new()
			sprite.texture = texture
			@warning_ignore("narrowing_conversion", "integer_division")
			var pos_x : int = (x - int(num_sprites_x/2)) * sprite_size.x + center.x
			@warning_ignore("integer_division", "narrowing_conversion")
			var pos_y : int = (y - num_sprites_y/2) * sprite_size.y + center.y
			sprite.position = Vector2(pos_x, pos_y)
			sprite.scale *= texture_scale
			call_deferred("add_child", sprite)
			background_sprites.append(sprite)

func _rearrange_sprites():
	# is too far left?
	if player.global_position.x < center.x - sprite_size.x/2:
		_move_all(-sprite_size.x, 0)
		center.x -= sprite_size.x
	# is too far right?
	elif player.global_position.x > center.x + sprite_size.x/2:
		_move_all(sprite_size.x, 0)
		center.x += sprite_size.x
	
	# is too far up?
	if player.global_position.y < center.y - sprite_size.y/2:
		_move_all(0, -sprite_size.y)
		center.y -= sprite_size.y
	# is too far down?
	elif player.global_position.y > center.y + sprite_size.y/2:
		_move_all(0, sprite_size.y)
		center.y += sprite_size.y

func _move_all(dx : float, dy : float) -> void:
	for sprite:Sprite2D in background_sprites:
		sprite.position.x += dx
		sprite.position.y += dy
