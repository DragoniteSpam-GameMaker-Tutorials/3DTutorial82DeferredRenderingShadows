varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vNormal;

varying float v_light_distance;
varying vec2 v_shadow_texcoord;

uniform sampler2D samp_shadowmap;

void main()
{
    float shadow_depth_value = texture2D(samp_shadowmap, v_shadow_texcoord).r;
    float shadow_bias = 0.0005;
    float in_shadow = 0.0;
    if (v_light_distance > shadow_depth_value + shadow_bias) {
        in_shadow = 1.0;
    }
    
    gl_FragData[0] = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragData[1] = vec4((v_vNormal.xyz * 0.5) + 0.5, 1);
    gl_FragData[2] = vec4(in_shadow, 0, 0, 1);
    
    if (gl_FragData[0].a < 0.25) {
        discard;
    }
}