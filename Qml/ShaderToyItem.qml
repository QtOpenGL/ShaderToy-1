import QtQuick 2.0
//uniform vec3      iResolution;           // viewport resolution (in pixels)
//uniform float     iGlobalTime;           // shader playback time (in seconds)
//uniform float     iChannelTime[4];       // channel playback time (in seconds)
//uniform vec3      iChannelResolution[4]; // channel resolution (in pixels)
//uniform vec4      iMouse;                // mouse pixel coords. xy: current (if MLB down), zw: click
//uniform samplerXX iChannel0..3;          // input channel. XX = 2D/Cube
//uniform vec4      iDate;                 // (year, month, day, time in seconds)
//uniform float     iSampleRate;           // sound sample rate (i.e., 44100)
ShaderEffect {
    id: shader
    readonly property vector3d  iResolution: Qt.vector3d(shader.width, shader.height, 0.0)
    property int        iFrame: 10
    property real       iGlobalTime: 0
    property var        iChannelTime: [0, 1, 2, 3]
    property var        iChannelResolution: [Qt.vector3d(shader.width, shader.height, 0.0)]
    property vector4d   iMouse;
    property var        iChannel0;
    property var        iChannel1;
    property var        iChannel2;
    property var        iChannel3;
    property vector4d   iDate;
    property real       iSampleRate: 44100
    property real       iTimeDelta: 100
    property alias hoverEnabled: mouse.hoverEnabled
    NumberAnimation on iGlobalTime {
        from: 0
        to: Math.PI * 2
        duration: 6914
        loops: Animation.Infinite;
    }
    Timer {
        id: timer
        running: true
        interval: 1000
        onTriggered: {
            var date = new Date();
            shader.iDate.x = date.getFullYear();
            shader.iDate.y = date.getMonth();
            shader.iDate.z = date.getDay();
            shader.iDate.w = date.getSeconds()
        }
    }
    MouseArea {
        id: mouse
        anchors.fill: parent
        //        propagateComposedEvents: true
        onPositionChanged: {
            shader.iMouse.x = mouseX
            shader.iMouse.y = mouseY
        }
        onClicked: {
            shader.iMouse.z = mouseX
            shader.iMouse.w = mouseY
        }
    }
    vertexShader: "
        uniform highp mat4 qt_Matrix;
        attribute highp vec4 qt_Vertex;
        attribute highp vec2 qt_MultiTexCoord0;
        varying highp vec2 coord;
        void main() {
            coord = qt_MultiTexCoord0;
            gl_Position = qt_Matrix * qt_Vertex;
        }"

    readonly property string forwardString: "
        #ifndef GL_ES
//        #extension GL_EXT_shader_texture_lod: enable
//        #extension GL_OES_standard_derivatives: enable

//        precision highp float;
//        precision highp int;
//        precision medium sampler2D;
        #endif

        #ifdef GL_ES
        precision mediump float;
        #endif

        uniform lowp   float qt_Opacity;
        varying highp  vec2  coord;

        uniform vec3   iResolution;
        uniform int    iFrame;
        uniform float  iGlobalTime;
        uniform float  iChannelTime[4];
        uniform vec3   iChannelResolution[4];
        uniform vec4   iMouse;
        uniform vec4    iDate;
        uniform float   iSampleRate;
        uniform sampler2D   iChannel0;
        uniform sampler2D   iChannel1;
        uniform sampler2D   iChannel2;
        uniform sampler2D   iChannel3;
    "
    readonly property string startCode: "
        void main(void)
        {
            mainImage(gl_FragColor, gl_FragCoord.xy);
        }"
    readonly property string defaultPixelShader: "
        void mainImage(out vec4 fragColor, in vec2 fragCoord)
        {
            fragColor = vec4(fragCoord, fragCoord.x, fragCoord.y);
        }"
    property string pixelShader: ""
    fragmentShader: forwardString + (pixelShader ? pixelShader : defaultPixelShader) + startCode
}
