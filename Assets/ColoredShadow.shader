// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:9361,x:33209,y:32712,varname:node_9361,prsc:2|custl-8162-OUT;n:type:ShaderForge.SFN_Blend,id:8162,x:32999,y:32996,varname:node_8162,prsc:2,blmd:10,clmp:True|SRC-7349-OUT,DST-525-OUT;n:type:ShaderForge.SFN_Lerp,id:7349,x:32680,y:32834,varname:node_7349,prsc:2|A-7485-RGB,B-6592-OUT,T-9701-OUT;n:type:ShaderForge.SFN_Color,id:7485,x:32013,y:32889,ptovrint:False,ptlb:Shadow Color,ptin:_ShadowColor,varname:node_7485,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Vector4,id:6592,x:32461,y:32895,varname:node_6592,prsc:2,v1:0,v2:0,v3:0,v4:0;n:type:ShaderForge.SFN_OneMinus,id:9701,x:32648,y:33120,varname:node_9701,prsc:2|IN-7953-OUT;n:type:ShaderForge.SFN_Multiply,id:7953,x:32437,y:33039,varname:node_7953,prsc:2|A-4900-OUT,B-9406-OUT;n:type:ShaderForge.SFN_OneMinus,id:4900,x:32257,y:32986,varname:node_4900,prsc:2|IN-8934-OUT;n:type:ShaderForge.SFN_Vector1,id:9406,x:32041,y:33300,varname:node_9406,prsc:2,v1:10;n:type:ShaderForge.SFN_LightAttenuation,id:8934,x:31765,y:33215,varname:node_8934,prsc:2;n:type:ShaderForge.SFN_Multiply,id:525,x:32874,y:33271,varname:node_525,prsc:2|A-8934-OUT,B-521-OUT,C-9464-RGB;n:type:ShaderForge.SFN_Blend,id:521,x:32495,y:33326,varname:node_521,prsc:2,blmd:10,clmp:True|SRC-7485-RGB,DST-6473-RGB;n:type:ShaderForge.SFN_Color,id:6473,x:32192,y:33381,ptovrint:False,ptlb:Diff Color,ptin:_DiffColor,varname:node_6473,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.9,c2:0.8,c3:0.7,c4:1;n:type:ShaderForge.SFN_LightColor,id:9464,x:32640,y:33435,varname:node_9464,prsc:2;proporder:7485-6473;pass:END;sub:END;*/

Shader "Shader Forge/ColoredShadow" {
    Properties {
        _ShadowColor ("Shadow Color", Color) = (0.5,0.5,0.5,1)
        _DiffColor ("Diff Color", Color) = (0.9,0.8,0.7,1)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _ShadowColor;
            uniform float4 _DiffColor;
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                LIGHTING_COORDS(0,1)
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                float3 lightColor = _LightColor0.rgb;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 finalColor = saturate(( (attenuation*saturate(( _DiffColor.rgb > 0.5 ? (1.0-(1.0-2.0*(_DiffColor.rgb-0.5))*(1.0-_ShadowColor.rgb)) : (2.0*_DiffColor.rgb*_ShadowColor.rgb) ))*_LightColor0.rgb) > 0.5 ? (1.0-(1.0-2.0*((attenuation*saturate(( _DiffColor.rgb > 0.5 ? (1.0-(1.0-2.0*(_DiffColor.rgb-0.5))*(1.0-_ShadowColor.rgb)) : (2.0*_DiffColor.rgb*_ShadowColor.rgb) ))*_LightColor0.rgb)-0.5))*(1.0-lerp(float4(_ShadowColor.rgb,0.0),float4(0,0,0,0),(1.0 - ((1.0 - attenuation)*10.0))))) : (2.0*(attenuation*saturate(( _DiffColor.rgb > 0.5 ? (1.0-(1.0-2.0*(_DiffColor.rgb-0.5))*(1.0-_ShadowColor.rgb)) : (2.0*_DiffColor.rgb*_ShadowColor.rgb) ))*_LightColor0.rgb)*lerp(float4(_ShadowColor.rgb,0.0),float4(0,0,0,0),(1.0 - ((1.0 - attenuation)*10.0)))) )).rgb;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _ShadowColor;
            uniform float4 _DiffColor;
            struct VertexInput {
                float4 vertex : POSITION;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                LIGHTING_COORDS(0,1)
                UNITY_FOG_COORDS(2)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                float3 lightColor = _LightColor0.rgb;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 finalColor = saturate(( (attenuation*saturate(( _DiffColor.rgb > 0.5 ? (1.0-(1.0-2.0*(_DiffColor.rgb-0.5))*(1.0-_ShadowColor.rgb)) : (2.0*_DiffColor.rgb*_ShadowColor.rgb) ))*_LightColor0.rgb) > 0.5 ? (1.0-(1.0-2.0*((attenuation*saturate(( _DiffColor.rgb > 0.5 ? (1.0-(1.0-2.0*(_DiffColor.rgb-0.5))*(1.0-_ShadowColor.rgb)) : (2.0*_DiffColor.rgb*_ShadowColor.rgb) ))*_LightColor0.rgb)-0.5))*(1.0-lerp(float4(_ShadowColor.rgb,0.0),float4(0,0,0,0),(1.0 - ((1.0 - attenuation)*10.0))))) : (2.0*(attenuation*saturate(( _DiffColor.rgb > 0.5 ? (1.0-(1.0-2.0*(_DiffColor.rgb-0.5))*(1.0-_ShadowColor.rgb)) : (2.0*_DiffColor.rgb*_ShadowColor.rgb) ))*_LightColor0.rgb)*lerp(float4(_ShadowColor.rgb,0.0),float4(0,0,0,0),(1.0 - ((1.0 - attenuation)*10.0)))) )).rgb;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
