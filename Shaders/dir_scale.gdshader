shader_type canvas_item;

uniform float scale = 0.;
uniform vec2 direction = vec2(0.);

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
	vec2 xy = 2. * SCREEN_UV - 1.;
	vec2 d_norm = normalize(direction);
	mat2 R = mat2(vec2(-d_norm.y, d_norm.x), vec2(d_norm.x, d_norm.y));
	mat2 R_inv = R;
	mat2 S_y = mat2(vec2(1., 0.), vec2(0., scale));
	mat2 M = R_inv * S_y * R;
	xy = M * xy;
	vec2 uv = .5 * xy + .5;
	COLOR = texture(SCREEN_TEXTURE, uv);
    if (uv.x > 1. || uv.x < 0.||  uv.y > 1. || uv.y < 0.)
        COLOR = vec4(0., 0., 0., 1.);
}