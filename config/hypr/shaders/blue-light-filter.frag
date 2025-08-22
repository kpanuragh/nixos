// Blue light filter shader for Hyprland
// This reduces blue light emission during evening hours

precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 pixColor = texture2D(tex, v_texcoord);
    
    // Reduce blue component by 30% and slightly reduce green
    pixColor.r = pixColor.r * 1.1; // Slight red boost
    pixColor.g = pixColor.g * 0.95; // Slight green reduction
    pixColor.b = pixColor.b * 0.7; // Significant blue reduction
    
    gl_FragColor = pixColor;
}
