varying vec2 v_vTexcoord;
varying float v_LightDepth;
varying vec4 v_vColor;

void main() {
    gl_FragColor = vec4(v_LightDepth, 0, 0, 1);
    if (texture2D(gm_BaseTexture, v_vTexcoord).a < 0.1) discard;
}