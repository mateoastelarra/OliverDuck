extends State
class_name PlayerGliding

@onready var player = $"../.."
@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var gliding_timer = $GlidingTimer

@export var gliding_ratio: float = 40
@export var gliding_time: float = .8

func Enter():
	animated_sprite.play("FallSC")
	gliding_timer.wait_time = gliding_time
	gliding_timer.one_shot = true
	gliding_timer.start()
	

func Exit():
	player.has_glided = true

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	player.velocity.y = gliding_ratio
	if player.is_on_floor():
		Transitioned.emit(self, "PlayerIdle")
	elif Input.is_action_just_released("glide"):
		Transitioned.emit(self, "PlayerFalling")
		


func _on_gliding_timer_timeout():
	Transitioned.emit(self, "PlayerFalling")

