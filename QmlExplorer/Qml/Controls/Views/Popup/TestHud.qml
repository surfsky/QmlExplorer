import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0

/**
测试hud
*/
Item{
    width: 640
    height: 480

    //
    Button {
        id: btnPopup
        anchors.centerIn: parent
        text: '显示hud'
        onClicked:{
            hud.show('HUD HUD HUD HUD');
        }
    }

    // 弹出层
    HUD {
        id: hud
        width: 200
        height: 50
        z: 101
        visible: false
        duration: 4000

        text: 'this is hud'
    }


}


