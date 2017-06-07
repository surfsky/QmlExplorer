import QtQuick 2.0
import QtQuick.Controls 1.1


Page {
    width: 360
    height: 360
    color: 'lightblue'

    title: 'page1'
    Button{
        y: 30
        text: 'go page2'
        onClicked: redirect('Page2.qml');
        anchors.centerIn: parent
    }
}
