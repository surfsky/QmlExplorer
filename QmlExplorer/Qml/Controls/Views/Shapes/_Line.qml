/**
Qml line
*/
import QtQuick 2.0
Rectangle {
    width: 100
    height: 1
    color: 'grey'
    property string direction : 'horizontal'
    property int size : 1

    function onDirectionChanged() {
        if (direction == 'horizontal')
            height = size;
        else
            width = size;
    }
}
