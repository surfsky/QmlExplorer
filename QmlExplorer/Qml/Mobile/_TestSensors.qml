import QtQuick 2.2
import QtQuick.Controls 1.2
import QtSensors 5.0


/**
迁移自示例项目：qmlqtsensors
Accelerometer               Element reports on linear acceleration along the X, Y and Z axes
Altimeter                   Element reports on altitude
AmbientLightSensor          Element repors on ambient lighting conditions
AmbientTemperatureSensor    Element reports on the ambient temperature
Compass                     Element reports on heading using magnetic north as a reference
DistanceSensor              Element reports the distance in cm from an object to the device
Gyroscope                   Element reports on rotational acceleration around the X, Y and Z axes
HolsterSensor               Element reports on whether a device is holstered
IRProximitySensor           Element reports on infra-red reflectance values
LightSensor                 Element reports on light levels using LUX
Magnetometer                Element reports on magnetic field strength along the Z, Y and Z axes
OrientationSensor           Element reports device orientation
PressureSensor              Element reports on atmospheric pressure values
ProximitySensor             Element reports on object proximity
RotationSensor              Element reports on device rotation around the X, Y and Z axes
TapSensor                   Element reports tap and double tap events along the X, Y and Z axes
TiltSensor                  Element reports tilt events along the X and Y axes
*/
ApplicationWindow {
    // Sensor types used
    //! [1]
    TiltSensor {
        id: tilt
        active: false
    }
    //! [1]

    AmbientLightSensor {
        id: ambientlight
        active: false
        //! [5]
        onReadingChanged: {
            if (reading.lightLevel == AmbientLightSensor.Unknown)
                ambientlighttext.text = "Ambient light: Unknown";
            else if (reading.lightLevel == AmbientLightSensor.Dark)
                ambientlighttext.text = "Ambient light: Dark";
            else if (reading.lightLevel == AmbientLightSensor.Twilight)
                ambientlighttext.text = "Ambient light: Twilight";
            else if (reading.lightLevel == AmbientLightSensor.Light)
                ambientlighttext.text = "Ambient light: Light";
            else if (reading.lightLevel == AmbientLightSensor.Bright)
                ambientlighttext.text = "Ambient light: Bright";
            else if (reading.lightLevel == AmbientLightSensor.Sunny)
                ambientlighttext.text = "Ambient light: Sunny";
        }
        //! [5]
    }

    ProximitySensor {
        id: proxi
        active: false
    }

    Column {
        spacing: 10
        anchors.fill: parent
        anchors.margins: 5

        Text {
            id: labelTitle
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 30
            font.bold: true
            text: "QML QtSensors"
        }

        // Tilt region
        Text { text: "TiltSensor（倾斜传感器）" }

        Row {
            spacing: 20
            width: parent.width
            anchors.margins: 5
            Button {
                id: calibrate
                height: 30
                width: 80
                text: "Calibrate"
                onClicked: tilt.calibrate();
            }
            Text {
                id: xrottext
                height: 30
                verticalAlignment: Text.AlignVCenter
                //! [3]
                text: "X Rotation: " + tilt.xRotation + "°"
                //! [3]
            }
        }
        Row {
            spacing: 20
            width: parent.width
            anchors.margins: 5
            Button {
                id: tiltStart
                height: 30
                width: 80
                text: tilt.active ? "Stop" : "Start"
                onClicked: {
                    //! [2]
                    tilt.active = (tiltStart.text === "Start");
                    //! [2]
                }
            }
            Text {
                id: yrottext
                height: 30
                verticalAlignment: Text.AlignVCenter
                //! [4]
                text: "Y Rotation: " + tilt.yRotation +  "°"
                //! [4]
            }
        }

        Text { text: "AmbientLightSensor（环境光传感器）" }

        Row {
            spacing: 20
            width: parent.width
            anchors.margins: 5

            Button{
                id: ambientlightStart
                height: 30
                width: 80
                text: ambientlight.active ? "Stop" : "Start"
                onClicked: {
                    ambientlight.active = (ambientlightStart.text === "Start" ? true : false);
                }
            }

            Text {
                id: ambientlighttext
                height: 30
                verticalAlignment: Text.AlignVCenter
                text: "Ambient light: Unknown"
            }
        }

        // Proximity region
        Text { text: "ProximitySensor（距离传感器）" }

        Row {
            spacing: 20
            width: parent.width
            anchors.margins: 5

            Button {
                id: proxiStart
                height: 30
                width: 80
                text: proxi.active ? "Stop" : "Start"

                onClicked: {
                    proxi.active = (proxiStart.text === "Start"  ? true: false);
                }
            }

            Text {
                id: proxitext
                height: 30
                verticalAlignment: Text.AlignVCenter
                //! [6]
                text: "Proximity: " +
                      (proxi.active ? (proxi.reading.near ? "Near" : "Far") : "Unknown")
                //! [6]
            }
        }
    }
}
