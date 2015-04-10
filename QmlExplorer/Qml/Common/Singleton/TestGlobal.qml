import QtQuick 2.0
import "."  // 单例模式必须显式的调用qmldir文件

/**
测试Global单例
*/
Rectangle {
    width: 500
    height: 500
    color: Global.bgColor;

    Text{
        text: 'hello world'
        font.pixelSize: Global.textSize
        color: Global.textColor
        anchors.centerIn: parent
    }
}
