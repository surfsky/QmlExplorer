import QtQuick 2.0
import QtQuick.Dialogs 1.2
import "../../controls/Views"

/**
touch和mouse事件分发
- 事件触发区内的每个组件都会收到touch事件
- 若不受理，转化为鼠标事件
- 如果还不受理，转给下个组件处理
- 阻止下层处理事件：onPressed事件中 mouse.accepted = true;
*/
Rectangle {
    width: 600
    height: 600

    // info
    function showInfo(title, info){
        logger.info(title, info);
    }


    // rect1
    Rectangle{
        id: rect1
        x:10; y:10;
        width: 200; height:200
        color: 'red'
        border.color: "white"
        border.width: mouse1.pressed ? 2 : 0
        MouseArea{
            id: mouse1
            anchors.fill: parent;
            onClicked:{
                showInfo('rect1', 'click');
            }
        }
    }

    // rect2（允许事件传递给下层处理）
    Rectangle{
        id: rect2
        x:50; y:50;
        width: 200; height:200
        color: 'green'
        opacity: 0.5
        border.color: "white"
        border.width: mouse2.pressed ? 2 : 0
        MouseArea{
            id: mouse2
            anchors.fill: parent;
            onClicked:{
                showInfo('rect2', 'click');
                mouse.accepted = false;
            }
        }
    }

    // rect3（自己不受理任何事件，且允许事件传递给下层处理）
    Rectangle{
        id: rect3
        x:100; y:100;
        width: 200; height:200
        color: 'blue'
        opacity: 0.5
        border.color: "white"
        border.width: mouse3.pressed ? 2 : 0
        MouseArea{
            id: mouse3
            anchors.fill: parent;
            onPressed: {
                // 阻止受理事件
                mouse.accepted = false;
            }
            onClicked:{
                showInfo('rect3', 'click');
                mouse.accepted = false;
            }
        }
    }

    // 阻止下层处理任何事件
    Rectangle{
        id: rect4
        x:150; y:150;
        width: 200; height:200
        color: 'lightgreen'
        opacity: 0.5
        border.color: "white"
        border.width: mouse4.pressed ? 2 : 0
        MouseArea{
            id: mouse4
            anchors.fill: parent;
            onPressed: {
                mouse.accepted = true;
                showInfo('rect4', 'pressed');
            }
        }
    }

    // logger
    ListLogger{
        id: logger
        width: 200
        height: parent.height
        x: parent.width - width

        maxLines: 20
    }
}
