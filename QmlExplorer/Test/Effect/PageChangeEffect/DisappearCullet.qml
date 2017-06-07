import QtQuick 2.3

/**
顶图飞散消失效果
逻辑很傻，抽空用canvas自动生成散图
*/
Rectangle {
    id: root
    width: image.width;
    height: image.height

    SystemPalette { id: activePalette }

    // 底图
    Image {
        id: image
        source: "Image/pic2.png"
    }

    // 一堆散图
    Image {
        id: image1
        source: "Image/pic1_1.png"
        states: [
            State {
                name: "on"
                PropertyChanges { target: image1; x: -490; rotation: 30 }
                PropertyChanges { target: image1; y: -370; rotation: -20 }
            }
        ]
        transitions: [
            Transition {
                NumberAnimation { properties: "x, y"; easing.type: Easing.OutQuad; duration: 1000 }
            }
        ]
    }

    Image {
        id: image2
        source: "Image/pic1_2.png"
        x: 180

        states: [
            State {
                name: "on"
                PropertyChanges { target: image2; x: -400; rotation: 45 }
                PropertyChanges { target: image2; y: -370; rotation: -45 }
            }
        ]

        transitions: [
            Transition {
                NumberAnimation { properties: "x, y"; easing.type: Easing.OutQuad; duration: 1000 }
            }
        ]
    }

    Image {
        id: image3
        source: "Image/pic1_3.png"
        y: 213

        states: [
            State {
                name: "on"
                PropertyChanges { target: image3; x: -490; rotation: -60 }
            }
        ]

        transitions: [
            Transition {
                NumberAnimation { properties: "x, y"; easing.type: Easing.OutQuad; duration: 1000 }
            }
        ]
    }

    Image {
        id: image4
        source: "Image/pic1_4.png"
        x: 180; y: 213

        states: [
            State {
                name: "on"
                PropertyChanges { target: image4; x: -490;  y: 370; rotation: 60 }
            }
        ]

        transitions: [
            Transition {
                NumberAnimation { properties: "x, y"; easing.type: Easing.OutQuad; duration: 1000 }
            }
        ]
    }

    Image {
        id: image5
        source: "Image/pic1_5.png"
        y: 427



        states: [
            State {
                name: "on"
                PropertyChanges { target: image5; x: -490; rotation: 270 }
                PropertyChanges { target: image5; y: -300; rotation: -270 }
            }
        ]

        transitions: [
            Transition {
                NumberAnimation { properties: "x, y"; easing.type: Easing.OutQuad; duration: 1000 }
            }
        ]
    }

    Image {
        id: image6
        source: "Image/pic1_6.png"
        x: 180; y: 427

        states: [
            State {
                name: "on"
                PropertyChanges { target: image6; x: -200; rotation: 120 }
                PropertyChanges { target: image6; y: -600; rotation: 100 }
            }
        ]

        transitions: [
            Transition {
                NumberAnimation { properties: "x, y"; easing.type: Easing.OutQuad; duration: 1000 }
            }
        ]
    }

    // 点击触发
    MouseArea{
        anchors.fill: parent
        onClicked: {
            image1.state = "on"
            image2.state = "on"
            image3.state = "on"
            image4.state = "on"
            image5.state = "on"
            image6.state = "on"
        }
    }
}

