Shader "Custom/Toon"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1) // Initial albedo and toon bars
        _ToonTex ("Toon Filter", 2D) = "white" {}
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf ToonRamp  // Toon Lighting model

        sampler2D _ToonTex; // defining variables/assets

        struct Input // Basic IO
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;
        
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
            o.Albedo = _Color.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse" // Fall back
}
