shader_type canvas_item;

uniform sampler2D unlitTexture;
uniform sampler2D litTexture;
uniform sampler2D binarydataTexture;
uniform int gridWidth;

const int cellSize = 8;
const float fadeDistance = 32.0;

void fragment() {
	// Total size, in pixels of the grid
	vec2 totalGridSize = vec2(float(gridWidth) * float(cellSize));
	
	// Scale the UV texture by our gridWidth
	vec2 scaledUV = UV * float(gridWidth);
	
	// 
	ivec2 cellIndex = ivec2(floor(scaledUV));
	
	vec2 cellUV = fract(scaledUV);
	bool isInsideCell = all(greaterThanEqual(cellUV, vec2(0.0))) && all(lessThan(cellUV, vec2(1.0)));
	
	// Calculate normalized UV coordinates for the binary data texture
	vec2 binaryDataUV = vec2(
		float(cellIndex.x) / float(gridWidth - 1),
		float(cellIndex.y) / float(gridWidth - 1)
	);
	
	// Read the binary value from the texture. specifically the Red Channel
	float binaryValue = texture(binarydataTexture, binaryDataUV).r;
	
	bool isWhite = binaryValue > 0.5;
	
	// Calculate distance to nearest border for the fade effect
	float distanceX = min(scaledUV.x, float(gridWidth) - scaledUV.x) * float(cellSize);
	float distanceY = min(scaledUV.y, float(gridWidth) - scaledUV.y) * float(cellSize);
	float distanceToBorder = min(distanceX, distanceY);
	
	
	// By default, make the color the unlit color
	vec4 color = texture(unlitTexture, cellUV);
	
	// If white and inside cell, make lit instead
	if(isWhite && isInsideCell){
		color = texture(litTexture, cellUV);
	}
	
	// Interpolate alpha
	float alpha = log(distanceToBorder * 1.0) / log(fadeDistance * 1.0);
	color.a = alpha;
	
	COLOR = color;
	
}
