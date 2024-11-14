attribute vec3 in_Position;
attribute vec2 in_TextureCoord;
attribute vec4 in_Colour;

varying vec2 v_vTexcoord;
varying float v_LightDepth;
varying vec4 v_vColor;

void main() {
    vec4 object_space_pos = vec4(in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    v_LightDepth = gl_Position.z / gl_Position.w;
    v_vTexcoord = in_TextureCoord;
    v_vColor = in_Colour;
}