extends State
class_name PlayerRunning

@onready var player = $"../.."
@onready var animated_sprite = $"../../AnimatedSprite2D"

func Enter():
	animated_sprite.play("Run")

func Exit():
	pass

func Update(_delta: float):
	var direction = Input.get_axis("move_left", "move_right")
	if !player.is_on_floor():
		Transitioned.emit(self, "PlayerJump")
	elif direction == 0:
		Transitioned.emit(self, "PlayerIdle")
	
	
func Physics_Update(_delta: float):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
