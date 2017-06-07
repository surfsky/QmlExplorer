import QtQuick 2.3

/**
preventStealing

指定mousearea中的鼠标事件能否被“偷”.
如果 MouseArea 被放置在一个 item 里面（会过滤子元素的鼠标事件），如 Flickable, 鼠标事件将会被“偷”，
如果该手势被上级元素所识别的话
如果 preventStealing 等于 true，会阻止鼠标事件被偷
Note that setting preventStealing to true once an item has started stealing events will have no effect
until the next press event.
默认值是 false.
*/
Rectangle {
    width: 400
    height: 400
    Flickable{
        anchors.fill: parent
        contentHeight: 900

        // 按住rect1可以继续拖动（鼠标事件被上级的flickable组件受理了）
        Rectangle {
            x:50; y:100
            width:200; height:100
            color:mouse1.pressed ? 'green' : 'red'
            Text{
                text: '点在我身上还可以拖动'
            }
            MouseArea{
                id: mouse1
                anchors.fill: parent;
                onPressed: mouse.accepted = false  // 点击无效
            }
        }

        // 按住rect2，只能触发点击事件，无法拖动（鼠标事件仅自己处理）
        Rectangle{
            x: 50; y:300;
            width:200; height:100
            color: mouse2.pressed ? 'red' : 'blue'
            Text{
                text: '点在我身上就不能拖动了'
            }
            MouseArea{
                id: mouse2
                anchors.fill: parent
                preventStealing: true   ////////
            }
        }
    }
}
