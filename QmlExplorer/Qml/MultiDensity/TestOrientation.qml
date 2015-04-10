import QtQuick 2.2
import QtSensors 5.0


/**
竖屏和横屏布局不一样
Screen.orientation
*/
Rectangle {
    width: 800
    height: 600

    states:[
        State{
            name: 'vertical'
        },
        State{
            name: 'horizontal'
        }
    ]

    Rectangle{
        id: rectTitle
        color: 'black'
        x:0; y:0
        width: parent.width
        height: 20
    }
    Rectangle{
        id: rectMenu
        color: 'lightgreen'
        x: 0
        y: rectTitle.height
        width: parent.width
        height: 300
        //height: parent.height-rectTitle
        //Component.onCompleted: height=parent.height-rectTitle
    }
    Rectangle{
        id: rectMain
        color: 'red'
        x:0;
        y:rectTitle.height+rectMenu.height
        width: parent.width
        height: 300
    }


    onWidthChanged: {
        if (width > 500) state = 'horizontal';
        else state = 'vertical';

    }
    

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
