import QtQuick 2.3

Rectangle {
    width: 600
    height: 600


/*
    // 用动态生成的方式有问题，两个rect都focus了
    Component {
        id: rect
        Rectangle {
            width: 200; height:200
            border.width: 1
            color: focus ? 'blue' : 'white'
            focus: true   // 这个必须加，否则无任何反应
            Text{
                text: 'focus:' + parent.focus + ' activeFocus:' + parent.activeFocus
            }
            MouseArea{
                anchors.fill: parent
                onClicked: parent.focus = true;
            }
        }
    }
    Loader { sourceComponent: rect; x:10;  y:10;}
    Loader { sourceComponent: rect; x:100; y:100 }
*/

    Rectangle {
        x: 10; y:10
        width: 200; height: 200
        border.width: 1
        color: focus ? 'blue' : 'white'
        focus: true   // 这个必须加，否则无任何反应
        activeFocusOnTab: true
        Text{
            text: 'focus:' + parent.focus + ' activeFocus:' + parent.activeFocus
        }
        MouseArea{
            anchors.fill: parent
            onClicked: parent.focus = true;
        }
    }

    Rectangle {
        x: 100; y:100
        width: 200; height: 200
        border.width: 1
        color: focus ? 'blue' : 'white'
        focus: true   // 这个必须加，否则无任何反应
        activeFocusOnTab: true
        Text{
            text: 'focus:' + parent.focus + ' activeFocus:' + parent.activeFocus
        }
        MouseArea{
            anchors.fill: parent
            onClicked: parent.focus = true;
        }
    }
}
