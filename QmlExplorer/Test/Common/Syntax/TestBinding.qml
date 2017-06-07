import QtQuick 2.1


// 绑定测试
// 经过测试，不用binding也可以将textedit的数据传递给text。。。
Column {
    width: 640
    height: 480
    spacing: 10

    Text {text:'demo 1------------------------------'}
    Text {id: txt1; text: "xxxfa"}
    TextEdit { id: edt1; text: "Please type here..." }
    Binding {
        when: mouse.pressed
        target: txt1;
        property: "text";
        value: edt1.text
    }

    Text {text:'demo 2------------------------------'}
    Text {id: txt2; text: edt2.text}
    TextEdit { id: edt2; text: "Please type here..." }
}
