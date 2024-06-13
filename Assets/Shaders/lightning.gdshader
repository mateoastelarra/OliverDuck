shader_type canvas_item;

uniform vec3 effect_color : source_color = vec3(0.2, 0.3, 0.8);
uniform int octaves_count : hint_range(1, 20) = 10;
uniform float amp_start = 0.5;
uniform float amp_coeff = 0.5;
uniform float freq_coeff = 2.0;

float noise(vec2 uv) {
	return sin(uv.x + uv.y);
}

float fbm(vec2 uv, int octaves) {
	float value = 0.0;
	float amplitude = amp_start;
	for(int i = 0; i < octaves; i++) {
		value += amplitude * noise(uv);
		uv *= freq_coeff;
		amplitude *= amp_coeff;
	}
	return value;
}

void fragment() {
	vec2 uv = 2.0 * UV - 1.0;
	uv += fbm(uv, octaves_count);
	float dist = abs(uv.x);
}




