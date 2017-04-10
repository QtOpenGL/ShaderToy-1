//shader input
//uniform vec3      iResolution;           // viewport resolution (in pixels)
//uniform float     iGlobalTime;           // shader playback time (in seconds)
//uniform float     iChannelTime[4];       // channel playback time (in seconds)
//uniform vec3      iChannelResolution[4]; // channel resolution (in pixels)
//uniform vec4      iMouse;                // mouse pixel coords. xy: current (if MLB down), zw: click
//uniform samplerXX iChannel0..3;          // input channel. XX = 2D/Cube
//uniform vec4      iDate;                 // (year, month, day, time in seconds)
//uniform float     iSampleRate;           // sound sample rate (i.e., 44100)

// main
void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec3 color1 = vec3(0.0, 0.0, 0.3);
    vec3 color2 = vec3(0.5, 0.0, 0.0);
    const float backWidth = 0.03;

    vec3 finalColor = vec3(1.0);
    vec3 backGroundColor = vec3(0.0);
    vec3 waveColor = vec3(0.0);

    float  c1 = mod(fragCoord.x, 2.0 * backWidth);
    c1 = step(backWidth, c1);

    float c2 = mod(fragCoord.y, 2.0 * backWidth);
    c2 = step(backWidth, c2);
    backGroundColor = mix(fragCoord.x * color1, fragCoord.y * color2, c1 * c2);
    fragColor = vec4(backGroundColor, 1.0);
}
