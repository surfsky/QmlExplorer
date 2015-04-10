import QtQuick 2.0
import QtQuick.Controls 1.1


Page {
    width: 360
    height: 360
    color: 'lightgreen'
    title: 'page2'
    Button{
        y: 30
        text: 'go page1'
        onClicked: redirect('Page1.qml');
        anchors.centerIn: parent
    }
}
