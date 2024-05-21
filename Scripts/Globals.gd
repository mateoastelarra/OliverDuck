extends Node

var player

#var fix_time  = OS.get_ticks_msec() - floor(OS.get_ticks_msec()/3600)*3600
var time = 0.0;

#func _ready():


func _process(delta):
	#fondo.gdshader.set_uniform_value("time", time)
	time += delta
	RenderingServer.global_shader_parameter_set("time", time);
	print("time is: ")
	print(time)
