import QtQuick 2.0
import "../"


/**
群组按钮示例，只有一个按钮是按下的
    /实现ios6风格的按钮组
    /属性：currentIndex
    封装成组件
        属性：texts:['1', '2', '3', '4']
        用repeater或listview实现
**/
Row {
    id: root

    property int currentIndex:0

    ImageButton{
        anchors.verticalCenter: parent.verticalCenter
        source: root.currentIndex==0 ? "btn_tab_left_active.png" : "btn_tab_left.png"
        clickShink: false
        text: 'Choose 1'
        textColor: root.currentIndex==0 ? 'white' : '#0000aa'
        onClicked: root.currentIndex = 0;
    }
    ImageButton{
        anchors.verticalCenter: parent.verticalCenter
        source: root.currentIndex==1 ? "btn_tab_middle_active.png" : "btn_tab_middle.png"
        clickShink: false
        text: 'Choose 2'
        textColor: root.currentIndex==1 ? 'white' : '#0000aa'
        onClicked: root.currentIndex = 1;
    }
    ImageButton{
        anchors.verticalCenter: parent.verticalCenter
        source: root.currentIndex==2 ? "btn_tab_right_active.png" : "btn_tab_right.png"
        clickShink: false
        text: 'Choose 3'
        textColor: root.currentIndex==2 ? 'white' : '#0000aa'
        onClicked: root.currentIndex = 2;
    }

}
