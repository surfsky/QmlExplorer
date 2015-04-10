import QtQuick 2.0


/**
测试动画速度曲线
- 一个待运动的物体
- 一个easying列表（带曲线图和文字的按钮）
- 点击让物体运动
*/

Rectangle {
    id: window
    width: 600; height: 460; color: "#232323"

    Flickable {
        anchors.fill: parent; contentHeight: layout.height
        Column {
            id: layout
            anchors.left: parent.left; anchors.right: parent.right
            Repeater { model: easingTypes; delegate: delegate }
        }
    }

    Component {
        id: delegate
        Item {
            height: 60; width: window.width
            Row{
                x: parent.width/2 - 50
                anchors.verticalCenter: parent.verticalCenter
                spacing: 5
                Image{
                    width: 42; height: 42
                    source: name + '.png'
                }
                Text { text: name; color: "White" }
            }

            Rectangle {
                id: slot1; color: "#121212"; x: 30; height: 32; width: 32
                border.color: "#343434"; border.width: 1; radius: 8
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle {
                id: slot2; color: "#121212"; x: window.width - 62; height: 32; width: 32
                border.color: "#343434"; border.width: 1; radius: 8
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle {
                id: rect; x: 30; color: "#454545"
                border.color: "White"; border.width: 2
                height: 32; width: 32; radius: 8
                anchors.verticalCenter: parent.verticalCenter

                MouseArea {
                    onClicked: if (rect.state == '') rect.state = "right"; else rect.state = ''
                    anchors.fill: parent
                }
                states : State {
                    name: "right"
                    PropertyChanges { target: rect; x: window.width - 62; color: ballColor }
                }
                transitions: Transition {
                    NumberAnimation { properties: "x"; easing.type: type; duration: 1000 }
                    ColorAnimation { properties: "color"; easing.type: type; duration: 1000 }
                }
            }
        }
    }


    ListModel {
        id: easingTypes
        ListElement { name: "Linear"; type: Easing.Linear; ballColor: "DarkRed" }
        ListElement { name: "InQuad"; type: Easing.InQuad; ballColor: "IndianRed" }
        ListElement { name: "OutQuad"; type: Easing.OutQuad; ballColor: "Salmon" }
        ListElement { name: "InOutQuad"; type: Easing.InOutQuad; ballColor: "Tomato" }
        ListElement { name: "OutInQuad"; type: Easing.OutInQuad; ballColor: "DarkOrange" }
        ListElement { name: "InCubic"; type: Easing.InCubic; ballColor: "Gold" }
        ListElement { name: "OutCubic"; type: Easing.OutCubic; ballColor: "Yellow" }
        ListElement { name: "InOutCubic"; type: Easing.InOutCubic; ballColor: "PeachPuff" }
        ListElement { name: "OutInCubic"; type: Easing.OutInCubic; ballColor: "Thistle" }
        ListElement { name: "InQuart"; type: Easing.InQuart; ballColor: "Orchid" }
        ListElement { name: "OutQuart"; type: Easing.OutQuart; ballColor: "Purple" }
        ListElement { name: "InOutQuart"; type: Easing.InOutQuart; ballColor: "SlateBlue" }
        ListElement { name: "OutInQuart"; type: Easing.OutInQuart; ballColor: "Chartreuse" }
        ListElement { name: "InQuint"; type: Easing.InQuint; ballColor: "LimeGreen" }
        ListElement { name: "OutQuint"; type: Easing.OutQuint; ballColor: "SeaGreen" }
        ListElement { name: "InOutQuint"; type: Easing.InOutQuint; ballColor: "DarkGreen" }
        ListElement { name: "OutInQuint"; type: Easing.OutInQuint; ballColor: "Olive" }
        ListElement { name: "InSine"; type: Easing.InSine; ballColor: "DarkSeaGreen" }
        ListElement { name: "OutSine"; type: Easing.OutSine; ballColor: "Teal" }
        ListElement { name: "InOutSine"; type: Easing.InOutSine; ballColor: "Turquoise" }
        ListElement { name: "OutInSine"; type: Easing.OutInSine; ballColor: "SteelBlue" }
        ListElement { name: "InExpo"; type: Easing.InExpo; ballColor: "SkyBlue" }
        ListElement { name: "OutExpo"; type: Easing.OutExpo; ballColor: "RoyalBlue" }
        ListElement { name: "InOutExpo"; type: Easing.InOutExpo; ballColor: "MediumBlue" }
        ListElement { name: "OutInExpo"; type: Easing.OutInExpo; ballColor: "MidnightBlue" }
        ListElement { name: "InCirc"; type: Easing.InCirc; ballColor: "CornSilk" }
        ListElement { name: "OutCirc"; type: Easing.OutCirc; ballColor: "Bisque" }
        ListElement { name: "InOutCirc"; type: Easing.InOutCirc; ballColor: "RosyBrown" }
        ListElement { name: "OutInCirc"; type: Easing.OutInCirc; ballColor: "SandyBrown" }
        ListElement { name: "InElastic"; type: Easing.InElastic; ballColor: "DarkGoldenRod" }
        ListElement { name: "OutElastic"; type: Easing.OutElastic; ballColor: "Chocolate" }
        ListElement { name: "InOutElastic"; type: Easing.InOutElastic; ballColor: "SaddleBrown" }
        ListElement { name: "OutInElastic"; type: Easing.OutInElastic; ballColor: "Brown" }
        ListElement { name: "InBack"; type: Easing.InBack; ballColor: "Maroon" }
        ListElement { name: "OutBack"; type: Easing.OutBack; ballColor: "LavenderBlush" }
        ListElement { name: "InOutBack"; type: Easing.InOutBack; ballColor: "MistyRose" }
        ListElement { name: "OutInBack"; type: Easing.OutInBack; ballColor: "Gainsboro" }
        ListElement { name: "OutBounce"; type: Easing.OutBounce; ballColor: "Silver" }
        ListElement { name: "InBounce"; type: Easing.InBounce; ballColor: "DimGray" }
        ListElement { name: "InOutBounce"; type: Easing.InOutBounce; ballColor: "SlateGray" }
        ListElement { name: "OutInBounce"; type: Easing.OutInBounce; ballColor: "DarkSlateGray" }
    }
}
