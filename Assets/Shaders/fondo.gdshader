shader_type canvas_item;

uniform int iterations = 3;
uniform float zoom = 5.0;
uniform float power = 0.5;
uniform float speed = 0.1;
uniform vec4 background: source_color = vec4(0.0, 0.0, 0.0, 1.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	//https://www.youtube.com/watch?v=D-Cl-yz7F4Q&list=PLNhMW555KBpm-_YdBkYH8mDmuf0svBRe-&index=33&ab_channel=FencerDevLog
	// Called for every pixel the material is visible on.
	float intensity = power * 0.01;
	float bright = 1.0;
	float time = TIME * speed;
	vec2 coords = 250.0 + UV / zoom;
	vec2 iter = vec2(coords);
	for (int n = 0; n < iterations; n++) {
		iter = coords + vec2(cos(time - iter.x) + sin(time + iter.y), sin(time - iter.x) + cos(time + iter.y));
		vec2 tmp = vec2(sin(time + iter.x), cos(time + iter.y));
		vec2 vector = vec2(coords.x / tmp.x, coords.y / tmp.y) * 0.005;
		bright += 1.0 / length(vector);
	}
	bright /= float(iterations);
	bright = 1.2 - pow(bright, 1.5);
	vec4 color = vec4(pow(abs(bright), 8.0));
	color = clamp(color + background, 0.0, 1.0);
	COLOR = color;
	//COLOR = vec4(sin(UV.x / UV.y) - cos(UV.x * time / UV.y), cos(UV.x / UV.y) + sin(UV.x / UV.y), 1.0, 1.0);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
