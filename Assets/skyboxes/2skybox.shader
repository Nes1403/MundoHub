Shader "Skybox/BlendInside"
{
    Properties
    {
        _Tex1 ("Skybox 1", Cube) = "" {}
        _Tex2 ("Skybox 2", Cube) = "" {}
        _Blend ("Blend Factor", Range (0, 1)) = 0
    }
    SubShader
    {
        Tags { "Queue" = "Background" }
        Cull Front ZWrite Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            samplerCUBE _Tex1;
            samplerCUBE _Tex2;
            float _Blend;

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 texcoord : TEXCOORD0;
            };

            v2f vert (float3 v : POSITION)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v);
                o.texcoord = v;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col1 = texCUBE(_Tex1, i.texcoord);
                fixed4 col2 = texCUBE(_Tex2, i.texcoord);
                return lerp(col1, col2, _Blend);
            }
            ENDCG
        }
    }
    FallBack "Skybox/Procedural"
}
