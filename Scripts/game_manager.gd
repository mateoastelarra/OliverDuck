extends Node

var score = 0
var player = null
var converted_animals = 0

func add_point():
	score += 1
	print(score)

func add_converted_animal():
	converted_animals += 1
	print(converted_animals)
