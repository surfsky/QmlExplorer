import QtQuick 2.0
import ".."

Flow {
    id: root

    property real tempValue: 0;

    height: childrenRect.height

    Repeater {
        id: repeater
        model: 162
        ProgressIndicator {
            size: "small"
            value: tempValue
            showPercentages: false
            highlightColor: Qt.rgba(index/repeater.count, x/root.width, 1.0-y/root.height, 1.0)
        }
    }

    Timer {
        interval: 400
        repeat: true
        running: true
        onTriggered: {
            tempValue += Math.random() * 0.1;
            if (tempValue >= 1.0) {
                tempValue = 0.0;
            }
        }
    }
}
