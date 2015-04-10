
import QtQuick 2.0


/**
测试pinchArea组件，可用两个手指头进行缩放操作
摘自官方游戏 touchinteraction
*/
Rectangle {
    width: 640
    height: 360
    color: "gray"

    Flickable {
        id: flick
        anchors.fill: parent
        contentWidth: 500
        contentHeight: 500

        PinchArea {
            width: Math.max(flick.contentWidth, flick.width)
            height: Math.max(flick.contentHeight, flick.height)

            property real initialWidth
            property real initialHeight
            onPinchStarted: {
                initialWidth = flick.contentWidth
                initialHeight = flick.contentHeight
            }

            onPinchUpdated: {
                // adjust content pos due to drag
                flick.contentX += pinch.previousCenter.x - pinch.center.x
                flick.contentY += pinch.previousCenter.y - pinch.center.y

                // resize content
                flick.resizeContent(initialWidth * pinch.scale, initialHeight * pinch.scale, pinch.center)
            }

            onPinchFinished: {
                // Move its content within bounds.
                flick.returnToBounds()
            }

            Rectangle {
                width: flick.contentWidth
                height: flick.contentHeight
                color: "white"
                Image {
                    anchors.fill: parent
                    source: "../../images/logo.png"
                    MouseArea {
                        anchors.fill: parent
                        onDoubleClicked: {
                            flick.contentWidth = 500
                            flick.contentHeight = 500
                        }
                    }
                }
            }
        }
    }
}
