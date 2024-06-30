extends Node

var score = 0
var player = null
var converted_animals = 0

func _input(_event):
	if Input.is_action_just_pressed("take_screenshot"):
		take_screenshot()

func add_point():
	score += 1
	print(score)

func add_converted_animal():
	converted_animals += 1
	print(converted_animals)

func take_screenshot():
	var timestamp = Time.get_datetime_string_from_system(false, true).replace(":", "-")
	await RenderingServer.frame_post_draw
	var sshot = get_viewport().get_texture().get_image()
	#next line (commented) resizes images
	#sshot.resize(200, 100, Image.INTERPOLATE_TRILINEAR)
	sshot.save_png("user://screenshot" + timestamp + ".png")
