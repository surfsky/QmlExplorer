import QtQuick 2.0
import QtGraphicalEffects 1.0

/**
InnerShader测试
*/
Flickable{
    width:1000
    height: 600
    contentHeight: 3000
    contentWidth: width

    Column {
        anchors.fill: parent


        Text{text: 'raw'}
        Image {
            id: butterfly
            source: "../images/butterfly.png"
            sourceSize: Qt.size(parent.width, parent.height)
            smooth: true
        }


        // color
        Text{text: 'color'}
        Row{
            InnerShadow {
                width: butterfly.width
                height: butterfly.height
                radius: 8.0
                samples: 16
                horizontalOffset: -3
                verticalOffset: 3
                color: "#b0000000"
                source: butterfly
            }
            InnerShadow {
                width: butterfly.width
                height: butterfly.height
                radius: 16.0
                samples: 24
                horizontalOffset: 0
                verticalOffset: 0
                color: "#ffffff"
                source: butterfly
                spread: 0.2
            }
            InnerShadow {
                width: butterfly.width
                height: butterfly.height
                radius: 16.0
                samples: 24
                horizontalOffset: 0
                verticalOffset: 0
                color: "#ff0000"
                source: butterfly
                spread: 0.2
            }
        }

        //
        Text{text: 'fast'}
        Row{
            InnerShadow {
                width: butterfly.width
                height: butterfly.height
                radius: 16
                samples: 24
                horizontalOffset: 0
                verticalOffset: 0
                color: "#000000"
                source: butterfly
                fast: false
            }
            InnerShadow {
                width: butterfly.width
                height: butterfly.height
                radius: 16
                samples: 24
                horizontalOffset: 0
                verticalOffset: 0
                color: "#000000"
                source: butterfly
                spread: 0.2
                fast: true
            }
        }

        //
        Text{text: 'radius'}
        Row{
            InnerShadow {
                width: butterfly.width
                height: butterfly.height
                radius: 6
                samples: 24
                horizontalOffset: 0
                verticalOffset: 0
                color: "#000000"
                source: butterfly
            }
            InnerShadow {
                width: butterfly.width
                height: butterfly.height
                radius: 16
                samples: 24
                horizontalOffset: 0
                verticalOffset: 0
                color: "#000000"
                source: butterfly
                spread: 0.2
            }
        }
    }
}

