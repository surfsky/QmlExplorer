import QtQuick 2.0
import QtQuick.Controls 1.1


// 测试PathView
// 根据指定路径显示数据
// 按左右键可切换当前选择项目
Rectangle {
    width: 240; height: 200

    // model
    ListModel {
        id: contactModel
        ListElement {
            name: "Bill Jones"
            icon: "http://qt-project.org/images/qt13a/Qt-logo.png"
        }
        ListElement {
            name: "Jane Doe"
            icon: "http://qt-project.org/images/qt13a/Qt-logo.png"
        }
        ListElement {
            name: "John Smith"
            icon: "http://qt-project.org/images/qt13a/Qt-logo.png"
        }
    }

    // delegate
    Component {
        id: delegate
        Column {
            id: wrapper
            Image {
                anchors.horizontalCenter: nameText.horizontalCenter
                width: 64; height: 64
                source: icon
            }
            Text {
                id: nameText
                text: name
                font.pointSize: 16
                color: wrapper.PathView.isCurrentItem ? "red" : "black"
            }
        }
    }

    // pathView
    PathView {
        anchors.fill: parent
        model: contactModel
        delegate: delegate
        path: Path {
            startX: 120; startY: 100
            PathQuad { x: 120; y: 25; controlX: 260; controlY: 75 }
            PathQuad { x: 120; y: 100; controlX: -20; controlY: 75 }
        }
        /*
        path: Path {
            startX: 120; startY: 100
            PathAttribute { name: "iconScale"; value: 1.0 }
            PathAttribute { name: "iconOpacity"; value: 1.0 }
            PathQuad { x: 120; y: 25; controlX: 260; controlY: 75 }
            PathAttribute { name: "iconScale"; value: 0.3 }
            PathAttribute { name: "iconOpacity"; value: 0.5 }
            PathQuad { x: 120; y: 100; controlX: -20; controlY: 75 }
        }
        */
        focus: true
        Keys.onLeftPressed: decrementCurrentIndex()
        Keys.onRightPressed: incrementCurrentIndex()
    }
}
