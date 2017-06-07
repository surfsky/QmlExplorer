import QtQuick 2.0
import QtQuick.Controls 1.2


/**
表单外观设置
还是直接用图片做背景方便
*/
Flickable {
    id: root
    width: 800
    height: 600
    contentWidth: width
    contentHeight: 8000

    property int rowHeight : 40;
    property int column1Width : 150;
    property color darkColor: '#e0e0e0'
    property color lightColor: '#f0f0f0'
    property color fieldColor: '#f9f9f9'

    Column{
        anchors.fill: parent
        anchors.margins: 10

        // head
        Rectangle{
            width: parent.width
            height: rowHeight
            clip: true
            Rectangle{
                color: darkColor
                width: parent.width
                height: rowHeight+radius
                radius: 10
                border.color: lightColor
                border.width: 1
            }
        }

        // row
        Repeater{
            width: parent.width
            model: 10
            delegate: Rectangle{
                width: parent.width
                height: rowHeight
                color: darkColor
                border.color: lightColor
                border.width: 1
                clip: true
                Rectangle{
                    x: column1Width
                    y: 0
                    width: parent.width - x
                    height: parent.height
                    color: fieldColor
                }
            }


        }



    }


}

