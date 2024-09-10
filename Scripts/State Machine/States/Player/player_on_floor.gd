extends State
class_name PlayerOnFloor

@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var player = $"../.."
@onready var jump_buffer_timer = $Timers/JumpBufferTimer
@onready var coyote_timer = $Timers/CoyoteTimer

var jump_available : bool = true
var jump_buffer : bool = false

func Enter():
	pass

func Exit():
	pass

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	if Input.is_action_just_pressed("jump"):
		player.velocity.y = player.jump_velocity
		jump_available = false
	else:
		jump_buffer = true
		jump_buffer_timer.start()
		
	if not player.is_on_floor():
		if jump_available:
			if coyote_timer.is_stopped():
				coyote_timer.start()
		player.velocity.y += player.get_gravity() * _delta
	else:
		jump_available = true
		coyote_timer.stop()
		if jump_buffer:
			player.velocity.y = player.jump_velocity
			jump_buffer = false

func _on_jump_buffer_timer_timeout():
	jump_buffer = false

func _on_coyote_timer_timeout():
	jump_available = false
