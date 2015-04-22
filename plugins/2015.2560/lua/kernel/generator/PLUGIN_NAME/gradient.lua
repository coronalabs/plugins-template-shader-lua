local kernel = {}

kernel.language = "glsl"

kernel.category = "generator"

kernel.group = "PLUGIN_NAME"

kernel.name = "gradient"

kernel.fragment =
[[
P_COLOR vec4 FragmentKernel( P_UV vec2 texCoord )
{
	P_COLOR vec4 color;
	color.rg = texCoord;
	color.ba = vec2( 1.0 );

	// Modulate by object's alpha/tint
	return CoronaColorScale( color );
}
]]

return kernel
