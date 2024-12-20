extends State
class_name PlayerFalling

@onready var player = $"../.."
@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var collision_shape_2d = $"../../CollisionShape2D"
@onready var player_wall_grab_timer = $"../../Timers/WallGrabTimer"

func Enter():
	animated_sprite.play("FallSC")

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
	elif !collision_shape_2d:
		Transitioned.emit(self, "PlayerDead")
	
	if player_wall_grab_timer.time_left > 0:
		if player.is_on_wall() and !player.is_on_floor():
			if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
				Transitioned.emit(self, "PlayerWallGrabbing")
