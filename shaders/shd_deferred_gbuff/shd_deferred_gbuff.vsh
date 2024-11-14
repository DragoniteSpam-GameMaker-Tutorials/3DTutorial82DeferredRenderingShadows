attribute vec3 in_Position;
attribute vec3 in_Normal;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vNormal;

uniform mat4 u_light_view_mat;
uniform mat4 u_light_proj_mat;

varying float v_light_distance;
varying vec2 v_shadow_texcoord;

void main()
{
    vec4 objectSpace = vec4(in_Position, 1);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * objectSpace;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
    v_vNormal = normalize(gm_Matrices[MATRIX_WORLD_VIEW] * vec4(in_Normal, 0)).xyz;
    
    vec4 world_space = gm_Matrices[MATRIX_WORLD] * objectSpace;
    vec4 shadow_view_space = u_light_view_mat * world_space;
    vec4 shadow_screen_space = u_light_proj_mat * shadow_view_space;
    
    v_light_distance = shadow_screen_space.z / shadow_screen_space.w;
    v_shadow_texcoord = ((shadow_screen_space.xy / shadow_screen_space.w) * 0.5) + 0.5;
}
