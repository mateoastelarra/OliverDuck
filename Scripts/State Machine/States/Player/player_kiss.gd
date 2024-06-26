extends State
class_name PlayerKiss

@onready var animated_sprite = $"../../AnimatedSprite2D"
@onready var player = $"../.."
@onready var state_machine = $".."

func Enter():
	player.kiss_finished = false
	animated_sprite.play("Kiss")
	
func Exit():
	pass

func Update(_delta: float):
	pass
	
func Physics_Update(_delta: float):
	if player.kiss_finished:
		Transitioned.emit(self, "PlayerIdle")

func _on_animated_sprite_2d_animation_finished():
	player.kiss_finished = true
		
