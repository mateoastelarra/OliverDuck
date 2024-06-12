extends State
class_name PlayerFalling

@onready var player = $"../.."
@onready var animated_sprite = $"../../AnimatedSprite2D"

func Enter():
	animated_sprite.play("Fall")

func Exit():
	pass

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	player.velocity.y += player.get_gravity() * _delta
	player.velocity.y = minf(player.velocity.y, player.falling_velocity_limit)
	if player.is_on_floor():
		Transitioned.emit(self, "PlayerIdle")
	elif Input.is_action_pressed("glide") and !player.has_glided:
		Transitioned.emit(self, "PlayerGliding")
