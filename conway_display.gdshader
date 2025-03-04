shader_type canvas_item;

uniform sampler2D tex;

void fragment() {
	COLOR = vec4(UV, 1.0, 1.0);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
