shader_type canvas_item;
global uniform float time;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	
	//COLOR = vec4(sin(UV.x / UV.y) - cos(UV.x * time / UV.y), cos(UV.x / UV.y) + sin(UV.x / UV.y), 1.0, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
