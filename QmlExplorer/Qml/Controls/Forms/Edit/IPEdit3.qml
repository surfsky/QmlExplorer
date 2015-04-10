import QtQuick 2.0

/**
IP输入框
功能
    /4个段，段中间用.分隔
    /输入校验
    /属性text
    /tab键导航
    /属性enable(Item内置）
eg
    IPEdit{id:edtIP; text: '192.168.1.1'; enabled: true}
    Button{text: 'Set IP'; onClicked: edtIP.text = '134.104.69.201';}
    Button{text: 'Get IP'; onClicked: lblIP.text = edtIP.text;}
    Text{id: lblIP}

Author: surfsky.cnblogs.com 2015-03
Lisence: MIT 请保留此声明
*/
Rectangle {
    id: root
    width: 120
    height: 18
    border.width: 1

    //------------------------------------
    // 公共属性
    //------------------------------------
    // 属性text
    property string text : '192.168.0.1'
    onTextChanged: {_setText(text);}
    function _setText(ip){
        var txts = ip.split('.');
        txt1.text = txts[0];
        txt2.text = txts[1];
        txt3.text = txts[2];
        txt4.text = txts[3];
    }
    function _getText(){
        text = txt1.text + "." + txt2.text + "." + txt3.text + "." + txt4.text;
    }

    //------------------------------------
    // 私有属性方法
    //------------------------------------
    property int _dotWidth : 5;


    //Binding {
    //    target: contactName; property: 'text'
    //    value: name; when: list.ListView.isCurrentItem
    //}

    //------------------------------------
    // UI
    //------------------------------------
    IntValidator    {id: intVal; bottom:0; top:255; }
    Row{
        width: parent.width-4
        height: parent.height-4
        anchors.centerIn: parent
        TextInput{
            id: txt1
            width: (parent.width - _dotWidth*3)/4
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter;
            selectByMouse: true; // 鼠标可以选择
            validator: intVal;
            focus: true
            KeyNavigation.tab: txt2
            onTextChanged: root._getText();
        }
        Text{text: '.'; anchors.verticalCenter: parent.verticalCenter; width:_dotWidth;}
        TextInput{
            id: txt2
            width: (parent.width - _dotWidth*3)/4
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter;
            selectByMouse: true; // 鼠标可以选择
            validator: intVal;
            KeyNavigation.tab: txt3
            onTextChanged: root._getText();
        }
        Text{text: '.'; anchors.verticalCenter: parent.verticalCenter; width:_dotWidth;}
        TextInput{
            id: txt3
            width: (parent.width - _dotWidth*3)/4
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter;
            selectByMouse: true; // 鼠标可以选择
            validator: intVal;
            KeyNavigation.tab: txt4
            onTextChanged: root._getText();
        }
        Text{text: '.'; anchors.verticalCenter: parent.verticalCenter; width:_dotWidth;}
        TextInput{
            id: txt4
            width: (parent.width - _dotWidth*3)/4
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter;
            selectByMouse: true; // 鼠标可以选择
            validator: intVal;
            onTextChanged: root._getText();
        }
    }
}

