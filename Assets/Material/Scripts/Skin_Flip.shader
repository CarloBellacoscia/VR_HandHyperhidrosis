Shader "Custom/Skin_Flip" {
    Properties{
        _Color("Color", Color) = (0.7075471,0.7075471,0.7075471,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Glossiness("Smoothness", Range(0,1)) = 0.5
        _Metallic("Metallic", Range(0,1)) = 0.0
    }
    SubShader{

          Tags { "RenderType" = "Opaque" }
          LOD 200

          Cull Front

          CGPROGRAM

          #pragma surface surf Lambert vertex:vert
          //#pragma surface surf Standard fullforwardshadows
          #pragma target 3.0


          sampler2D _MainTex;

           struct Input {
               float2 uv_MainTex;
               float4 color : COLOR;
           };

           half _Glossiness;
           half _Metallic;
           fixed4 _Color;

          void vert(inout appdata_full v)
          {
              v.normal.xyz = v.normal * -1;
          }

          void surf(Input IN, inout SurfaceOutput o) {
               fixed4 result = tex2D(_MainTex, IN.uv_MainTex) * _Color;
               o.Albedo = result.rgb;
               //o.Alpha = 1;
               // Metallic and smoothness come from slider variables
               //o.Metallic = _Metallic;
               //o.Smoothness = _Glossiness;
               o.Alpha = result.a;
          }

          ENDCG

    }

        Fallback "Diffuse"
}