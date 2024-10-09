Shader "Custom/Toon+Rim"
{
	Properties 
	{
		_RimColor ("Rim color", Color) = (0,0.5,0.5,0)
		_RimPower ("Rim Power", Range(0.5,8.0)) = 3.0
		_Color ("Color", Color) = (1,1,1,1)
        _RampTex ("Ramp", 2D) = "white" {}
	}
	SubShader 
	{
		CGPROGRAM
		#pragma surface surf ToonRamp

		struct Input {
			float3 viewDir;
		};

		float4 _RimColor;
		float _RimPower;
		sampler2D _RampTex;
        float4 _Color;

		float4 LightingToonRamp (SurfaceOutput s, fixed3 lightDir, fixed atten)
        {
            float diff = dot (s.Normal, lightDir);
            float h = diff * 0.5 + 0.5;
            float2 rh = h;
            float3 ramp = tex2D(_RampTex, rh).rgb;

            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
            c.a = s.Alpha;
            return c;
        }

		void surf (Input IN, inout SurfaceOutput o){
			half rim = 1.0 - saturate(dot(normalize(IN.viewDir), o.Normal));
			o.Emission = _RimColor.rgb * pow(rim, _RimPower);
			o.Albedo = _Color.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}

