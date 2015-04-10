import QtQuick 2.0
import QtQuick.Controls 1.2

Item {
    id:container
    width: 320
    height: 480

    Column {
        spacing:5
        anchors.fill: parent
        anchors.topMargin: 12
        Text {
            font.pointSize: 24
            font.bold: true
            text: "Squircle with Clip"
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#777"
        }
        RoundCornerEffector{
            imagefile:"./images/bug.png"
            nSize: sldN.value
            radius: sldR.value
        }
    }
    Column {
        id: controls
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        Row{
            Text{text:"N     "}
            Slider {id: sldN; minimumValue: 1; maximumValue: 10; value: 4;}
        }
        Row{
            Text{text:"Radius"}
            Slider {id: sldR; minimumValue: 30; maximumValue: 180; value: 80;}
        }
    }
}
