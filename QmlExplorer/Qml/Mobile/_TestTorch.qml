import QtQuick 2.0
import QtQuick.Controls 1.2
import QtMultimedia 5.0

/**
测试手电筒
在sansung 939测试无效
*/
Rectangle{
    width:500; height:500

    Row{
        width: 300
        height: 300
        anchors.centerIn: parent
        spacing: 10

        Label{text: 'open torch'}
        Switch {
            checked: true
            onCheckedChanged: {
                torch.enabled = checked;
            }
        }
    }

    Torch {
        id: torch
        power: 75       // 75% of full power
        enabled: true   // On
    }
}

