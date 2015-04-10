import QtQuick 2.0
import QtQuick.Controls 1.2

/**
遮罩效果测试
定时自动取消遮罩
*/
Item{
    width: 640
    height: 480

    //
    Button {
        id: btnPopup
        anchors.centerIn: parent
        text: '显示Mask'
        onClicked:{
            mask.visible = true;
            timer.start();
        }
    }

    // mask会自动寻找根节点并铺满
    Rectangle{
        width:200; height:200
        x:10; y:10
        color: 'lightblue'

        Rectangle{
            width:200; height:200
            x:50; y:50
            color: 'lightyellow'

            Mask{
                id: mask
                visible: false;
            }
        }
    }


    Timer{
        id: timer
        interval: 3000
        repeat: false
        onTriggered: mask.visible = false;
    }
}
