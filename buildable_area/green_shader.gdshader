shader_type canvas_item;

void fragment() {
	vec4 previous_color = texture(TEXTURE, UV);
	vec4 green_color =  vec4(0.0, 1.0, 0.0, previous_color.a);
	COLOR = green_color;
}