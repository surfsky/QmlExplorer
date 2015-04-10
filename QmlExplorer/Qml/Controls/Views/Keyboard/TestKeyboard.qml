import QtQuick 2.0
import QtQuick.Controls 1.2


/**
测试软键盘
   /显隐
   /屏蔽物理按键
   /在光标位置增减字符
*/
Column {
    width: 800
    height: 600

    Row{
        width: parent.width
        spacing: 10
        Button{
            text: 'show'
            onClicked: keyboard.show(edt);
        }
        Button{
            text: 'hide'
            onClicked: keyboard.hide();
        }
    }
    Row
    {
        width: parent.width
        spacing: 10
        TextInput{
            id: edt
            width: parent.width/2-5
            text: '(1)...'
            font.pixelSize: 30
            onFocusChanged: {
                if (focus) keyboard.show(edt);
            }
            Keys.onPressed: event.accepted = true;  // 屏蔽物理按键
        }
        TextEdit{
            id: edt2
            width: parent.width/2-5
            text: '(2)...'
            color: 'green'
            font.pixelSize: 30
            onFocusChanged: {
                if (focus) keyboard.show(edt2);
            }
            Keys.onPressed: event.accepted = true;  // 屏蔽物理按键
        }
    }


    // 软键盘面板
    KeyboardPanel{
        id:keyboard
        width: parent.width
        visible:false
    }
}

