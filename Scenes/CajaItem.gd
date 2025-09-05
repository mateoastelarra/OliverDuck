extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_body_entered(body):
	# The 'body' variable will hold the node that collided with the block.
	# It will likely be your player (e.g., a CharacterBody2D).
	print("Collision detected with: ", body.name)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
