﻿Shader "Faxime/Introduction/4. Diffuse Auto-Ambient"
{
	Properties
	{
		_DiffuseColor("Diffuse Color", Color) = (1.0, 1.0, 1.0, 1.0)
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM
									
			// =============================================================================
			// Pragma Directives
			// =============================================================================

			#pragma vertex mainVertex
			#pragma fragment mainFrag
						
			// =============================================================================
			// Include Directives
			// =============================================================================

			#include "UnityCG.cginc"

			// =============================================================================
			// Uniform Variables
			// =============================================================================

			uniform float4 _DiffuseColor;
				
			// =============================================================================
			// Constants
			// =============================================================================

			static const float AmbientFactor = 0.2;

			// =============================================================================
			// Structures
			// =============================================================================
	
			struct vertexInput 
			{
				float4 Vertex : POSITION;
				float3 Normal : NORMAL;
			};

			struct vertexOutput
			{
				float4 Position : SV_POSITION;
				float4 Color : COLOR;
			};

			// =============================================================================
			// Vertex Function
			// =============================================================================

			vertexOutput mainVertex(vertexInput input)
			{
				vertexOutput output;

				// Transforms the vertex position from object space to world space.
				output.Position = mul(UNITY_MATRIX_MVP, input.Vertex);

				// Calculates the light's direction in world space.
				float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
				
				// Calculates the vertex's surface normal in object space.
				float3 normal = normalize(mul(float4(input.Normal, 0.0), unity_WorldToObject).xyz);

				// Calculates the light's intensity on the vertex.
				float intensity = dot(normal, lightDirection);

				// Calculates the vetex's ambient color, based on its diffuse color.
				float4 ambientColor = _DiffuseColor * AmbientFactor;

				//if (intensity > 0)
				//{
				//	output.col = float4(_DiffuseColor.xyz*intensity, 1.0F);
				//}
				//else
				//{
				//	output.col = float4(ambientColor.xyz, 1.0F);
				//}

				output.Color = max(_DiffuseColor*intensity, ambientColor);

				return output;
			}

			// =============================================================================
			// Fragment Function
			// =============================================================================

			float4 mainFrag(vertexOutput input) : COLOR
			{
				return input.Color;
			}

			ENDCG
		}
	}
}