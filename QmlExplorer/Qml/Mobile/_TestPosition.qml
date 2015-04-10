/**
测试定位功能
*/
import QtQuick 2.2
import QtSensors 5.0
import QtPositioning 5.2

Rectangle {
    width: 100
    height: 62

    Text{
        id: lblInfo
        text: 'Coodinate: ...'
        anchors.centerIn: parent
    }

    PositionSource {
        id: src
        updateInterval: 1000
        active: true

        onPositionChanged: {
            var coord = src.position.coordinate;
            lblInfo.text = "Coordinate:" + coord.longitude + "," + oord.latitude;
        }
    }
}
