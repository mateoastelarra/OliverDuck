extends Node2D


@onready var timer = $Timer

@export var shooting_rate: float = 1
var player
var cooling_down : bool = false


func _ready():
	player = Globals.player
	Globals.player.bullet_shot.connect(_on_player_shot)
	timer.wait_time = shooting_rate
	timer.one_shot = true


func _on_player_shot(bullet_scene, location):
	if cooling_down:
		return
	
	cooling_down = true
	var bullet = bullet_scene.instantiate()
	bullet.global_position = location
	if player.looking_direction:
		bullet.direction = player.looking_direction.normalized()
	add_child(bullet)
	timer.start()


func _on_timer_timeout():
	cooling_down = false
