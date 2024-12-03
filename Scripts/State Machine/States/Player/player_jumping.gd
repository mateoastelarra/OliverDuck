extends State
class_name PlayerJumping

@onready var player = $"../.."
@onready var animated_sprite = $"../../AnimatedSprite2D"

func Enter():
	animated_sprite.play("JumpSC")
	pass
	
func Exit():
	pass

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	player.velocity.y += player.get_gravity() * _delta
	player.velocity.y = minf(player.velocity.y, player.falling_velocity_limit)
	if player.velocity.y > 0:
		Transitioned.emit(self, "PlayerFalling")
		
	if player.is_on_wall() and !player.is_on_floor():
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			Transitioned.emit(self, "PlayerWallGrabbing")
