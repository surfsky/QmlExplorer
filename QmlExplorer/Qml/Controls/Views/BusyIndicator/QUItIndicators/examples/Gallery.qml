import QtQuick 2.0
import ".."

Item {
    id: root

    property real tempValue: 0;
    property bool tempRunning: true;

    height: contentArea.height

    Grid {
        id: contentArea
        x: (root.width - width)/2
        y: 40
        columns: root.width < 448 ? 1 : root.width < 2*448 ? 3 : 6
        rowSpacing: 50
        BusyIndicator {
            size: "small"
            running: tempRunning
            Text {
                y: -30
                font.pixelSize: 16
                color: "#b0b0b0"
                styleColor: "#000000"
                style: Text.Raised
                text: "BusyIndicators"
            }
        }
        BusyIndicator {
            running: tempRunning
        }
        BusyIndicator {
            size: "large"
            running: tempRunning
        }

        ProgressIndicator {
            size: "small"
            value: tempValue
            running: tempRunning
            Text {
                y: -30
                font.pixelSize: 16
                color: "#b0b0b0"
                styleColor: "#000000"
                style: Text.Raised
                text: "ProgressIndicators"
            }
        }
        ProgressIndicator {
            value: tempValue
            running: tempRunning
        }
        ProgressIndicator {
            size: "large"
            value: tempValue
            running: tempRunning
        }

        BusyIndicator {
            size: "small"
            running: tempRunning
            invertedTheme: true
            Text {
                y: -30
                font.pixelSize: 16
                color: "#b0b0b0"
                styleColor: "#000000"
                style: Text.Raised
                text: "BusyIndicators - Inverted Theme"
            }
        }
        BusyIndicator {
            running: tempRunning
            invertedTheme: true
        }
        BusyIndicator {
            size: "large"
            running: tempRunning
            invertedTheme: true
        }

        ProgressIndicator {
            size: "small"
            value: tempValue
            running: tempRunning
            invertedTheme: true
            Text {
                y: -30
                font.pixelSize: 16
                color: "#b0b0b0"
                styleColor: "#000000"
                style: Text.Raised
                text: "ProgressIndicators - Inverted Theme"
            }
        }
        ProgressIndicator {
            value: tempValue
            running: tempRunning
            invertedTheme: true
        }
        ProgressIndicator {
            size: "large"
            value: tempValue
            running: tempRunning
            invertedTheme: true
        }
    }

    SequentialAnimation {
        running: true
        loops: Animation.Infinite
        NumberAnimation {
            target: root
            property: "tempValue"
            from: 0
            to: 1
            duration: 5000
            easing.type: Easing.InOutQuad
        }
        PropertyAction {
            target: root
            property: "tempRunning"
            value: false
        }
        PauseAnimation { duration: 480 }
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
