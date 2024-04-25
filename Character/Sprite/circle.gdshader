shader_type canvas_item;

uniform float circle_size: hint_range(0, 1) = .5f;

void fragment(){
	if (distance(vec2(.5, .5), UV) < circle_size){
		COLOR.a = 1.f;
		
	}
}
