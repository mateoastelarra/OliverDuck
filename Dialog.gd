extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_proximity_area_body_entered(body):
	if body == self:
		return
	print(body)
	if body.name == "Player":
		print("Player is nearby!")
		print("Hi!")
