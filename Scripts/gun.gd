extends Node2D

@onready var timer = $Timer
@onready var GameManager = %GameManager
@onready var color_rect = $"../CanvasLayer/ColorRect"

@export var shooting_rate: float = 1
var player
var cooling_down : bool = false

func _ready():
	player = Globals.player
	Globals.player.bullet_shot.connect(_on_player_shot)
	timer.wait_time = shooting_rate
	timer.one_shot = true
	color_rect.visible = true

func shockwave(origin):
	#var projection = GameManager.to_2D(enemy.position) / (get_window().size as Vector2);
	var projection = origin;
	var material = color_rect.get_material()
	material.set_shader_parameter("center", projection)
	color_rect.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(material, "shader_parameter/size", 2.0, 2.0)
	tween.tween_callback(hide_shader_rect)
	
func hide_shader_rect():
	color_rect.visible = false

func _on_player_shot(bullet_scene, location):
	if cooling_down:
		return
	
	cooling_down = true
	var bullet = bullet_scene.instantiate()
	bullet.global_position = location
	print(location.normalized())
	shockwave(location.normalized())
	if player.looking_direction:
		bullet.direction = player.looking_direction.normalized()
	add_child(bullet)
	timer.start()

func _on_timer_timeout():
	cooling_down = false
