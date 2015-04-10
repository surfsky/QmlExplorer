import QtQuick 2.3
import QtQuick.Controls 1.2

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Column{
        anchors.fill: parent
        spacing: 10

        // buttons
        Row{
            width: parent.width
            Button{
                text: 'quit'
                onClicked: Qt.quit();
            }
            Button{
                text: 'copy image'
                onClicked: {
                    rect.grabToImage(function(result) {
                        console.log(result);
                        //result.saveToFile("something.png");
                        //Utils.setClipboardImage(result);
                    });
                }
            }
        }

        //
        Rectangle{
            id: rect
            width: 200
            height: 200
            color: 'lightblue'
            radius: 10

            Rectangle{
                width: 100
                height: 100
                color: 'lightgreen'
                radius: 10
                anchors.centerIn: parent
            }
        }
    }
}
