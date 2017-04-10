import QtQuick 2.2

Item {
    id: root
    width: 125
    height: 48
    property int fps: 0
    property int frameCounter: 0

    Image {
        id: spinnerImage
        source: "qrc:/Image/spinner.png"
        NumberAnimation on rotation {
            from:0
            to: 360
            duration: 800
            loops: Animation.Infinite
        }
        onRotationChanged: ++frameCounter
    }

    Text {
        id: fpsText
        x: 500
        text: root.fps + " fps"
        color: "white"
        font.pixelSize: 24
        style: Text.Outline
        styleColor: "#606060"
        anchors.right: parent.right
        anchors.verticalCenter: spinnerImage.verticalCenter
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            fps = frameCounter
            frameCounter = 0
        }
    }
}
