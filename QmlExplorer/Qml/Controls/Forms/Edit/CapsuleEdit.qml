import QtQuick 2.0

/**有胶囊形外观的文本输入框; 宽度随着文本的录入而自动增加*/
Rectangle {
    width: txt.width + 30
    height: 30
    radius: height/2
    color: 'lightblue'

    property alias text : txt.text;
    property alias fontSize : txt.font.pointSize;

    TextInput{
        id: txt
        width: 100
        font.pointSize: 14
        anchors.verticalCenter: parent.verticalCenter
        focus: true
        x: parent.radius
        onTextChanged: {
            width = Math.max(100, contentWidth);
            parent.width = width + parent.height;
        }
    }
}

