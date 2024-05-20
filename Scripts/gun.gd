extends Node2D

var player
func _ready():
	player = Globals.player
	Globals.player.bullet_shot.connect(_on_player_shot)


func _on_player_shot(bullet_scene, location):
	var bullet = bullet_scene.instantiate()
	bullet.global_position = location
	if player.looking_direction:
		bullet.direction = player.looking_direction.normalized()
		print(player.looking_direction)
	add_child(bullet)
