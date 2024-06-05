shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_nearest;
uniform vec2 center = vec2(0.5, 0.5);
uniform float power = 0.05;
uniform float size = 0.0;
uniform float sharpness = 0.1;
uniform float thickness = 0.1;

void fragment() {
	vec2 frag_uv = SCREEN_UV;
	float aspect_ratio = SCREEN_PIXEL_SIZE.x / SCREEN_PIXEL_SIZE.y;
	vec2 aspect_uv = (frag_uv - vec2(0.5, 0.0)) / vec2(aspect_ratio, 1.0) + vec2(0.5, 0.0);
	float outer = 1.0 - smoothstep(size - sharpness, size, length(aspect_uv - center));
	float inner = smoothstep(size - sharpness - thickness, size - thickness, length(aspect_uv - center));
	float ring = outer * inner;
	vec2 displacement = normalize(aspect_uv - center) * power * ring;
	COLOR = texture(SCREEN_TEXTURE, frag_uv - displacement);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
