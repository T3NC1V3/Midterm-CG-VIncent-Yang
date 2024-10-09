Shader "Custom/Color Grade"
{
     Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _ColorTint ("Tint", Color) = (1.0, 0.6, 0.6, 1.0)
        _Color ("Color", Color) = (1,1,1,1) // Initial albedo and toon bars
        _ToonTex ("Toon Filter", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        CGPROGRAM

        #pragma surface surf ToonRamp finalcolor:mycolor 

        sampler2D _MainTex;
        fixed4 _ColorTint;
        sampler2D _ToonTex;
        fixed4 _Color;

        struct Input
        {
            float2 uv_MainTex;
        };

        void mycolor (Input IN, SurfaceOutput o, inout fixed4 color)
        {
            color *= _ColorTint;
        }

        float4 LightingToonRamp (SurfaceOutput s, fixed3 lightDir, fixed atten) // Self defining Lighting model for Toon
        {
            float diff = dot (s.Normal, lightDir);
            float h = diff * 0.5 + 0.5;
            float2 rh = h;
            float3 ramp = tex2D(_ToonTex, rh).rgb; // Clamping the Texture

            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (ramp); 
            c.a = s.Alpha;
            return c;
            }

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
