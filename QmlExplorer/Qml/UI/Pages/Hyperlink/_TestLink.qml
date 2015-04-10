import QtQuick 2.0
import QtQuick.Controls 1.2
import "../../../../Js/common.js" as Common

Rectangle {
    id: root
    width: 600
    height: 400

    SplitView{
        anchors.fill: parent
        orientation: Qt.Horizontal

        Rectangle {
            id: menu
            width: parent.width * 0.4
            color: "lightblue"
            Column{
                anchors.centerIn: parent
                spacing: 10
                Link{
                    text: 'Page1'
                    url: '../Page1.qml'
                    container: container1
                    onClicked: Common.printChildren(container1, 0)
                }
                Link{
                    text: 'Page2'
                    url: '../Page2.qml'
                    container: container1
                    onClicked: Common.printChildren(container1, 0)
                }
                Link{
                    text: 'Page3 FullScreen'
                    url: '../Page3.qml'
                    onClicked: Common.printChildren(root, 0)
                }
                Link{
                    text: 'mailto'
                    url: 'mailto:15305770111@189.cn'
                    onClicked: Common.printChildren(container1, 0)
                }
            }
        }
        Rectangle {
            id: container1
            width: parent.width * 0.6
            color: "lightgreen"
        }
    }
}
