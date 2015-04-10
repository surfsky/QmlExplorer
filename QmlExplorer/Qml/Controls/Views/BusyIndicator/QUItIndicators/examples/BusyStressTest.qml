import QtQuick 2.0
import ".."

Flow {
    id: root
    height: childrenRect.height
    Repeater {
        model: 162
        BusyIndicator {
            size: "small"
            running: true
            invertedTheme: Math.floor(Math.random()+0.5)
        }
    }
}


