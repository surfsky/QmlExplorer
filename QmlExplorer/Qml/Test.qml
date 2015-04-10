import QtQuick 2.0
import QtQuick.Controls 1.2


Image{
    width: 600
    height: 600
    source: "http://qt-project.org/images/qt13a/Qt-logo.png"

    Rectangle{
        width: 400
        height: 400
        anchors.centerIn: parent
        color: '#aaff0000'
        //opacity: 0.8

        Rectangle{
            width: 100
            height: 100
            color: 'green'
            anchors.centerIn: parent
        }
    }

}
