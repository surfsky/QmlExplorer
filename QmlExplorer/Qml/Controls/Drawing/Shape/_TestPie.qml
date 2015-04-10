import QtQuick 2.0


/**
pie图表控件，目标：
PieChart {
    anchors.centerIn: parent
    width: 100; height: 100
    slices: [
        PieSlice {
            anchors.fill: parent
            color: "red"
            fromAngle: 0; angleSpan: 110
        },
        PieSlice {
            anchors.fill: parent
            color: "black"
            fromAngle: 110; angleSpan: 50
        },
        PieSlice {
            anchors.fill: parent
            color: "blue"
            fromAngle: 160; angleSpan: 100
        }
    ]
}
改为组件：
    piedata

*/
Rectangle {
    width: 100
    height: 100


    PieSlice {
        anchors.fill: parent
        color: "red"
        start: 0;
        end: 110
        onClicked: lblInfo.text=color;
    }
    PieSlice {
        anchors.fill: parent
        color: "black"
        start: 110;
        end: 160
        onClicked: console.log(color);
    }
    PieSlice {
        anchors.fill: parent
        color: "blue"
        start: 160;
        end: 260
        onClicked: console.log(color);
    }

    Text{
        id: lblInfo
        x: parent.width - contentWidth - 10
        y: 10
        text: 'color'
        font.pixelSize: 20
        font.bold: true
        color: 'black'
    }
}
