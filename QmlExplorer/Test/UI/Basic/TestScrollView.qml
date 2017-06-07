import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1


/**
测试ScrollView
    ScrollView 对现有的Flickable进行了补充，但是添加了滚动条和框的支持。
    它既可以被单独使用，也可以和现有的Flickable项一起使用
    例如，可以为ListView添加滚动条。
*/
Flow {
    id: root
    width: 640
    height: 800


    // 默认的scrollview
    ScrollView {
        width: parent.width
        height: 400
        flickableItem.interactive: true   // 必须加上该语句，否则会丧失了拖拽滑动的功能
        Image { source: "../../../images/splash/splash_640.png" }
    }

    // 自定义scrollview外观
    ScrollView{
        width: parent.width
        height: 200
        flickableItem.interactive: true   // 必须加上该语句，否则会丧失了拖拽滑动的功能

        ListView {
            anchors.fill: parent
            model: 200
            delegate: Text{text: index}
        }

        style: ScrollViewStyle {
                transientScrollBars: true
                handle: Item {
                    implicitWidth: 14
                    implicitHeight: 26
                    Rectangle {
                        color: "#424246"
                        anchors.fill: parent
                        anchors.topMargin: 6
                        anchors.leftMargin: 4
                        anchors.rightMargin: 4
                        anchors.bottomMargin: 6
                        opacity: 0.8
                        radius: width/2
                    }
                }
                scrollBarBackground: Item {
                    implicitWidth: 14
                    implicitHeight: 26
                }
            }
    }


}
