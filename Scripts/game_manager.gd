extends Node
@onready var GameManager = %GameManager
@onready var color_rect = $"../CanvasLayer/ColorRect"

var score = 0
var player = null
var converted_animals = 0

func _ready():
	color_rect.visible = false

func add_point():
	score += 1
	print(score)

func shockwave(enemy):
	#var projection = GameManager.to_2D(enemy.position) / (get_window().size as Vector2);
	var projection = 0.5;
	var material = color_rect.get_material()
	material.set_shader_parameter("center", projection)
	color_rect.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(material, "shader_parameter/size", 2.0, 2.0)
	tween.tween_callback(hide_shader_rect)
	
func hide_shader_rect():
	color_rect.visible = false

func add_converted_animal():
	shockwave(0.0)
	converted_animals += 1
	print(converted_animals)
