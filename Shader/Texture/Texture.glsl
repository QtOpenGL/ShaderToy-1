//shader input
//uniform vec3      iResolution;           // viewport resolution (in pixels)
//uniform float     iGlobalTime;           // shader playback time (in seconds)
//uniform float     iChannelTime[4];       // channel playback time (in seconds)
//uniform vec3      iChannelResolution[4]; // channel resolution (in pixels)
//uniform vec4      iMouse;                // mouse pixel coords. xy: current (if MLB down), zw: click
//uniform samplerXX iChannel0..3;          // input channel. XX = 2D/Cube
//uniform vec4      iDate;                 // (year, month, day, time in seconds)
//uniform float     iSampleRate;           // sound sample rate (i.e., 44100)

//just show one texture
// main
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 coord = vec2(fragCoord.x / iResolution.x, fragCoord.y / iResolution.y);
    fragColor = texture2D(iChannel0, coord);
}
