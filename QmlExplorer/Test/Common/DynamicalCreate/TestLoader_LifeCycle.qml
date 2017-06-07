import QtQuick 2.0
import QtQuick.Controls 1.2

/**
Loader 切换源时先创建新组建，再删除旧组件
*/
Column {
    id: root
    width: 640
    height: 480
    spacing: 10

    Button{
        text: 'load rect1'
        onClicked: loader.source = "Rect1.qml"
    }
    Button{
        text: 'load rect2'
        onClicked: loader.source = "Rect2.qml"
    }
    Loader {
        id: loader
        x: 10; y: 100
    }

}
