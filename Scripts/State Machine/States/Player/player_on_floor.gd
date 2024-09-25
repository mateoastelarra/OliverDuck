extends State
class_name PlayerOnFloor

@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var player = $"../.."
@onready var jump_buffer_timer = $JumpBufferTimer
@onready var coyote_timer = $CoyoteTimer

var jump_available : bool = true
var jump_buffer : bool = false

func Enter():
	print("enter")
	animated_sprite.play("IdleSC")
	jump_buffer_timer.wait_time = player.jump_buffer_time
	print("wait time")
	print(jump_buffer_timer.wait_time)
	jump_buffer_timer.one_shot = true
	pass
	

func Exit():
	pass

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	print("time left: ")
	print(jump_buffer_timer.time_left)
	if Input.is_action_just_pressed("jump"):
		print("Input.is_action_just_pressed()")
		player.velocity.y = player.jump_velocity
		jump_available = false
	elif jump_buffer_timer.is_stopped():
		print("jump_buffer_timer.start()")
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


#func _on_jump_buffer_timer_timeout():
	#print("_on_jump_buffer_timer_timeout")
	#jump_buffer = false
	#pass

func _on_coyote_timer_timeout():
	print("_on_coyote_timer_timeout")
	jump_available = false
	pass


func _on_jump_buffer_timer_timeout():
	print("_on_jump_buffer_timer_timeout")
	jump_buffer = false
	pass
