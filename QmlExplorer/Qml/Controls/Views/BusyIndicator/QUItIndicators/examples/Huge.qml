import QtQuick 2.0
import ".."

Item {
    id: root

    property real tempValue: 0;
    property bool tempRunning: true;

    height: contentArea.height

    ProgressIndicator {
        anchors.centerIn: parent
        size: "huge"
        value: tempValue
        running: tempRunning
        highlightColor: Qt.rgba(1.0, 1.0 - tempValue, 1.0, 1.0)
    }

    SequentialAnimation {
        running: true
        loops: Animation.Infinite
        NumberAnimation {
            target: root
            property: "tempValue"
            from: 0
            to: 1
            duration: 8000
            easing.type: Easing.InOutQuad
        }
        PropertyAction {
            target: root
            property: "tempRunning"
            value: false
        }
        PauseAnimation { duration: 500 }
        PropertyAction {
            target: root
            property: "tempValue"
            value: 0
        }
        PropertyAction {
            target: root
            property: "tempRunning"
            value: true
        }
    }
}
