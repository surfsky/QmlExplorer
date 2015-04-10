import QtQuick 2.0


/**
自定义panel组件
    icon、title
    collapse、collapsable
    content
    innerMargin
*/
Rectangle {
    id: root
    width: 300
    height: 200
    clip: false

    property int expandHeight : 200

    property alias headHeight: head.height
    property alias headColor: head.color
    property alias headRadias: head.radius
    property alias seperatorColor: seperator.color

    property alias icon : headImage.source
    property alias title : headText.text
    property bool collapse : false;
    property bool collapsable : true;
    property alias content : loader.sourceComponent;


    // head
    Rectangle{
        id: head
        height: 34
        width: parent.width
        color: 'lightblue'
        border.color: 'lightgrey'
        radius: 5

        Text{
            id: headText
            text: 'title'
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Text{
            id: headIndicator
            text: '>'
            rotation: -90
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10

            Behavior on rotation {
                RotationAnimation{duration: 500; easing.type: Easing.OutBounce}
            }
        }
        Rectangle{
            id: seperator
            color: 'yellow'
            height: parent.radius
            width: parent.width
            anchors.bottom: parent.bottom
        }

        MouseArea{
            id: headArea
            anchors.fill: parent
            onClicked: {
                if (root.collapsable){
                    if (root.height > root.headHeight) {
                        root.height = headHeight;
                        headIndicator.rotation = 90
                    }
                    else {
                        root.height = expandHeight;
                        headIndicator.rotation = -90
                    }
                }
            }
        }
    }


    // body
    Rectangle{
        id: body
        width: parent.width
        anchors.top : head.bottom
        anchors.bottom: parent.bottom
        color: 'white'
        border.color: 'lightgrey'
        Loader{
            id: loader
            anchors.fill: parent
            anchors.margins: 5
        }
    }

    // headImage
    Image{
        id: headImage
        source: 'http://qt-project.org/images/qt13a/Qt-logo.png'
        x: 5
        y: -5
        width: 30
        height:30
    }


    Behavior on height{
        NumberAnimation{duration: 500; easing.type: Easing.OutBounce}
    }

}
