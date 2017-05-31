import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Window 2.1


/**
带遮罩的繁忙指示器（未完成）
    带遮罩
    延时处理
    超时处理

bug
- 反复running，loading死循环不消失
- delay参数有问题
*/
Item{
    id: root
    width: 200   //Screen.width
    height: 200  //Screen.height
    anchors.fill: parent

    // signal
    signal delayFinished;
    signal timeoutFinished;

    // property
    property var tag;                       // 附属数据
    property int delay : 500                // 启动延时（可用于防止反复触发）
    property int timeout : 3000             // 超时时限（如网络故障的处理）
    property alias showMask : mask.visible  // 是否显示遮罩
    property alias maskColor : mask.color   // 遮罩色彩

    // function
    function startWithCallback(tag, delayCallback, timeoutCallback){
        if (delayCallback != null) root.delayFinished = delayCallback;
        if (timeoutCallback != null) root.timeoutFinished = timeoutCallback;
        start(tag);
    }
    function start(tag){
        if (this.visible)
            return;
        root.tag = tag;
        this.visible = true;
        mask.visible = true;
        busyIndicator.running = true;
        if (delay > 0)   timer1.running = true;
        if (timeout > 0) timer2.running = true;
    }
    function stop(){
        if (!this.visible)
            return;
        timer1.running = false;
        timer2.running = false;
        this.visible = false;
        busyIndicator.running = false;
        mask.visible = false;
    }



    // 繁忙指示器
    BusyIndicator{
        id: busyIndicator
        z:99
        width:20
        height:20
        anchors.centerIn: parent.Center
        running: true
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    // 遮罩
    Rectangle{
        id : mask
        z:98
        anchors.centerIn: parent
        anchors.fill: parent
        visible:true
        color: "#44000000"
        Behavior on color{
            ColorAnimation { duration: 200 }
        }
        MouseArea{
            anchors.fill: parent;
            onClicked : mouse.accepted = true
        }
    }

    // 延时定时器
    Timer {
        id : timer1
        interval: delay;
        running: false;
        repeat: false
        onTriggered: root.delayFinished();
    }

    // 超时定时器
    Timer {
        id : timer2
        interval: timeout;
        running: false;
        repeat: false
        onTriggered: {
            root.visible = false;
            root.timeoutFinished();
        }
    }
}
