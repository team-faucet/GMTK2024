shader_type canvas_item;

uniform float aspect = 1.0;

uniform float alpha = 1.0;
uniform vec4 crop_color = vec4(0.0, 0.0, 0.0, 1.0);

uniform float effect = 1.0;
uniform float effect_scale = 1.0;
uniform float scale = 1.0;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_linear;

vec2 distort(vec2 p) {
	float d = length(p);
	float z = sqrt(1.0 + d * d * -effect);
	float r = atan(d, z) / PI;
	r *= effect_scale;
	float phi = atan(p.y, p.x);
	return vec2(r * cos(phi) * (1.0 / aspect) + 0.5, r * sin(phi) + 0.5);
}

void fragment() {
	vec2 xy = (SCREEN_UV * 2.0 - 1.0);
	xy = vec2(xy.x * aspect, xy.y);
	xy /= scale;

	float d = length(xy);
	float z = sqrt(1.0 + d * d * -effect);
	float r = atan(d, z) / PI;
	float phi = atan(xy.y, xy.x);
	r *= effect_scale;
	vec2 uv = vec2(r * cos(phi) * (1.0 / aspect) + 0.5, r * sin(phi) + 0.5);

	if (d > r) {
		COLOR = texture(SCREEN_TEXTURE, uv);
		COLOR.a = alpha;
	}
	else {
		COLOR = crop_color;
	}

	if (uv.x < 0. || uv.y < 0. || uv.x > 1. || uv.y > 1.)
		COLOR = crop_color;
}