/**
测试用tab键导航
*/
import QtQuick 2.0
import QtQuick.Controls 1.1
Column {
    width: 640
    height: 480
    spacing: 5

    // 方法一: 用activeFocusOnTab
    TextField {
        id: txt1
        text: 'textfield1'
        activeFocusOnTab: true
        focus: true
    }
    TextField {
        id: txt2
        text: 'textfield2'
        activeFocusOnTab: true
    }
    Button {
        text: 'button'
        activeFocusOnTab: true
        onClicked: console.log('click')
        KeyNavigation.tab: txt3
    }

    // 方法二：手工指定tab跳到的下一个对象KeyNavigation.tab
    // 系统优先用这个方法，可能会打乱方法一的顺序
    TextField {
        id: txt3
        text: 'textfield2'
        KeyNavigation.tab: txt4
    }
    TextField {
        id: txt4
        text: 'textfield2'
        KeyNavigation.tab: txt3
        KeyNavigation.backtab: txt1
    }
}
