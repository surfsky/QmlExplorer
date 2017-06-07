import QtQuick 2.2
import QtQuick.Controls 1.1

/**测试Math全局对象*/
Column {
    x: 10
    y: 10
    width: 480
    height: 320
    spacing: 10

    Row{
        id: row1
        spacing: 10
        Button{
            width:60
            text:'go'
            onClicked: {lbl1.text = Math.round(Math.random(1000)* 1000);}
        }
        Text{
            id: lbl1
            text: 'random()'
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Row{
        id: row2
        spacing: 10
        Button{
            width:60
            text:'go'
            onClicked: {lbl2.text = Math.PI * 5;}
        }
        Text{
            id: lbl2
            text: 'PI * 5'
            anchors.verticalCenter: parent.verticalCenter
        }
    }

}
