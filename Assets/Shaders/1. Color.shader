﻿Shader "Faxime/Introduction/1. Color"
{
	Properties
	{
		_Color("Color", Color) = (1.0, 1.0, 1.0, 1.0)
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM

			// =============================================================================
			// Pragma Directives
			// =============================================================================

			#pragma vertex vertex
			#pragma fragment fragment

			// =============================================================================
			// Include Directives
			// =============================================================================

			#include "UnityCG.cginc"

			// =============================================================================
			// Uniform Variables
			// =============================================================================

			uniform float4 _Color;
	
			// =============================================================================
			// Structures
			// =============================================================================

			struct vertexInput 
			{
				float4 vertex : POSITION;
			};

			struct vertexOutput
			{
				float4 pos : SV_POSITION;
			};

			// =============================================================================
			// Vertex Function
			// =============================================================================

			vertexOutput vertex(vertexInput input)
			{
				vertexOutput output;

				output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
				
				return output;
			}

			// =============================================================================
			// Fragment Function
			// =============================================================================

			float4 fragment(vertexOutput input) : COLOR
			{
				return _Color;
			}

			ENDCG
		}
	}
}