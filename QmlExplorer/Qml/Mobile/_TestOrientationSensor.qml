import QtQuick 2.2
import QtSensors 5.0

Rectangle {
    width: 100
    height: 62


    OrientationSensor {
        id: orientation
        active: true

        onReadingChanged: {
            if (reading.orientation == OrientationReading.TopUp)
                console.log("TopUp");
            else if (reading.orientation == OrientationReading.TopDown)
                console.log("TopDown");
            else if (reading.orientation == OrientationReading.LeftUp)
                console.log("LeftUp");
            else if (reading.orientation == OrientationReading.RightUp)
                console.log("RightUp");
            else if (reading.orientation == OrientationReading.FaceUp)
                console.log("FaceUp");
            else if (reading.orientation == OrientationReading.FaceDown)
                console.log("FaceDown");
            else
                console.log("default");
         }
     }

}
