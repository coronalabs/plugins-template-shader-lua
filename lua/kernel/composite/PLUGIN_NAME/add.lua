local kernel = {}

kernel.language = "glsl"

kernel.category = "composite"

kernel.group = "PLUGIN_NAME"

kernel.name = "add"

kernel.vertexData =
{
	{
		name = "alpha",
		default = 1,
		min = 0,
		max = 1,
		index = 0, -- CoronaVertexUserData.x
	},
}

kernel.fragment =
[[
P_COLOR vec4 Add( in P_COLOR vec4 base, in P_COLOR vec4 blend )
{
	return base + blend;
}

P_COLOR vec4 FragmentKernel( P_UV vec2 texCoord )
{
	// Sample each texture
	P_COLOR vec4 base = texture2D( u_FillSampler0, texCoord );
	P_COLOR vec4 blend = texture2D( u_FillSampler1, texCoord );

	P_COLOR vec4 result = Add( base, blend );

	// Weight contributions of each texture
	result = mix( base, result, CoronaVertexUserData.x );

	// Modulate by object's alpha/tint
	return CoronaColorScale( result );
}
]]

return kernel
