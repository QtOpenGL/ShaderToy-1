import QtQuick 2.7
import QtQuick.Controls 1.4
import Reader 1.0
import Finder 1.0
ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("ShaderToys")
    color: "black"
    ShaderToyItem {
        id: toy
        anchors.fill: parent
        pixelShader: reader.result

        iChannel0: ShaderEffectSource{
            hideSource: true
            textureMirroring: ShaderEffectSource.NoMirroring
            sourceItem: Image {
                property int index: comboBox.currentIndex
                source: ""
                onIndexChanged: {
                    source = "qrc" + finder.absolutePaths[index] + "/iChannel0.png"
                }
            }
        }
        iChannel1: ShaderEffectSource{
            hideSource: true
            textureMirroring: ShaderEffectSource.NoMirroring
            sourceItem: Image {
                property int index: comboBox.currentIndex
                source: ""

                onIndexChanged: {
                    source = "qrc" + finder.absolutePaths[index] + "/iChannel1.png"
                }
            }
        }
        iChannel2: ShaderEffectSource{
            hideSource: true
            textureMirroring: ShaderEffectSource.NoMirroring
            sourceItem: Image {
                property int index: comboBox.currentIndex
                source: ""
                onIndexChanged: {
                    source = "qrc" + finder.absolutePaths[index] + "/iChannel2.png"
                }
            }
        }
        iChannel3: ShaderEffectSource{
            hideSource: true
            textureMirroring: ShaderEffectSource.NoMirroring
            sourceItem: Image {
                property int index: comboBox.currentIndex
                source: ""
                onIndexChanged: {
                    source = "qrc" + finder.absolutePaths[index] + "/iChannel3.png"
                }
            }
        }
    }

    Reader {
        id: reader
        source: ""
        result: ""
    }
    Finder {
        id: finder
        path: ""
        suffix: "glsl"
        onTargetsChanged: {
            iModel.clear();
            for (var i in targets) {
                iModel.append( {source:targets[i]});
            }
        }
        Component.onCompleted: path = ":/Shader"
    }
    ListModel {
        id: iModel
    }
    ComboBox {
        id: comboBox
        model: iModel
        Component.onCompleted: {
            currentIndex = 0;
        }
        onCurrentIndexChanged: {
            reader.source = currentText;
        }
    }
    Loader {
        id: fps
        x: root.width - width - 10
        y: 10
        source: "qrc:/Qml/Fps.qml"
    }


}
