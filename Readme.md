# ShaderToy Qml Demo
参考网站 https://www.shadertoy.com

## 示例图片

![](Image/demo1.png)

![](Image/demo2.png)

![](Image/demo3.png)

## 说明
截图是在老电脑上跑的，所以FPS太低了。

我做了一个Shader搜索器，会自动搜索指定路径下所有子目录，找到扩展名为glsl的文件并添加到ComboBox的列表中。
所以只要在Comboox中选择一下，就可以方便地切换不同的Shader。

## 关于ShadeToy

所有的Shader都有一个统一的输入
```
//uniform vec3      iResolution;           // viewport resolution (in pixels)
//uniform float     iGlobalTime;           // shader playback time (in seconds)
//uniform float     iChannelTime[4];       // channel playback time (in seconds)
//uniform vec3      iChannelResolution[4]; // channel resolution (in pixels)
//uniform vec4      iMouse;                // mouse pixel coords. xy: current (if MLB down), zw: click
//uniform samplerXX iChannel0..3;          // input channel. XX = 2D/Cube
//uniform vec4      iDate;                 // (year, month, day, time in seconds)
//uniform float     iSampleRate;           // sound sample rate (i.e., 44100)
```

所有的Shader都有统一的入口
```
void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    ...
}
```
## qml对shaderoy的封装：

qml 提供了Shaderffect，可以直接使用Shader代码。
使用Shaderffect对Shaderoy的封装如下：

```
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
    ...
}
```

## LinkList

https://shadertoy.com/view/MdX3zr

https://shadertoy.com/view/Ms2SD1

https://shadertoy.com/view/Xds3zN

https://shadertoy.com/view/XsXXDn

