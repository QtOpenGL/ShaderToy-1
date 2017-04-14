//shader input
//uniform vec3      iResolution;           // viewport resolution (in pixels)
//uniform float     iGlobalTime;           // shader playback time (in seconds)
//uniform float     iChannelTime[4];       // channel playback time (in seconds)
//uniform vec3      iChannelResolution[4]; // channel resolution (in pixels)
//uniform vec4      iMouse;                // mouse pixel coords. xy: current (if MLB down), zw: click
//uniform samplerXX iChannel0..3;          // input channel. XX = 2D/Cube
//uniform vec4      iDate;                 // (year, month, day, time in seconds)
//uniform float     iSampleRate;           // sound sample rate (i.e., 44100)

//reference: http://blog.csdn.net/stalendp/article/details/21993227

// main
void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec3 color1 = vec3(0.0, 0.0, 0.3);
    vec3 color2 = vec3(0.5, 0.0, 0.0);

    //fragCoord 取值范围是[0 - width], 不是[0, 1]
    vec2 uv = vec2(fragCoord.x / iResolution.x, fragCoord.y / iResolution.y);

    float backWidth = 0.03;

    vec3 finalColor = vec3(1.0);
    vec3 backGroundColor = vec3(0.0);
    vec3 waveColor = vec3(0.0);

    float  c1 = mod(uv.x, 2.0 * backWidth);
    c1 = step(backWidth, c1);

    float c2 = mod(uv.y, 2.0 * backWidth);
    c2 = step(backWidth, c2);
    backGroundColor = mix(uv.x * color1, uv.y * color2, c1 * c2);

    //[0, 1] -> [-1, 1]
    uv = 2.0 * uv - 1.0;
//    uv.y += 0.1;
//    uv.y += (0.07 * sin(uv.x * 10 + iGlobalTime));
    float waveWidth = abs(1.0 / (150.0 * uv.y));
    waveColor = vec3(waveWidth * 1.9, waveWidth, waveWidth * 1.5);
    for (float i = 0.0; i < 10.0; i++) {
        uv.y += (0.07 * sin(uv.x + i/7.0 + iGlobalTime));
        waveWidth = abs(1.0 / (150.0 * uv.y));
        waveColor += vec3(waveWidth * 1.9, waveWidth, waveWidth * 1.5);
    }
    finalColor = backGroundColor + waveColor;
    fragColor = vec4(finalColor, 1.0);
}
