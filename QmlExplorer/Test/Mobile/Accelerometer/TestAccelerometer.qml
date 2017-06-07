import QtQuick 2.0
import QtQuick.Window 2.0
import QtSensors 5.3


/**
qmake
open xxx.xcodeproject
*/
Rectangle {
    id: mainWindow
    color: 'white'

    Image{
        source: "../../images/logo.png"
        rotation: Screen.orientation === Qt.PortraitOrientation ? 0 : -90
        Behavior on rotation{
            NumberAnimation{
                duration: 1000
                easing.type: Easing.OutBounce
            }
        }
    }

    Accelerometer {
        active: true
        onReadingChanged: print(reading.x, reading.y)
    }
}
