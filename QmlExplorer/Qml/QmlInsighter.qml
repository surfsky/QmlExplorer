import QtQuick 2.0
import QtQuick.Controls 1.2
import "./Js/qml.js" as Qml


/**
qml 结构解析器
    /先用文本显示
    改成上下结构
        上面用树控件，显示物理结构
        下面用表格，显示详细属性
tip
    建议参考qtcreator源码
*/
Column{
    id: root
    width: 400
    height: 600
    clip: true

    property Item target : this;
    //onTargetChanged: show(target);  // 会导致重复调用
    function show(item){
        target = item;
        if (target == null)
            txt.text = '';
        else
            txt.text = Qml.getChildrenString(target, 0);
    }

    // 控制区
    Rectangle{
        width: parent.width
        height: 30
        color: '#f0f0f0'
        Button{
            id: btnUpdate
            text: 'update'
            anchors.verticalCenter: parent.verticalCenter
            onClicked: show(target);
        }
    }

    // 结构展示区
    TextArea {
        id: txt
        width: parent.width
        height: parent.height - 30
        wrapMode: Text.NoWrap
    }

    Component.onCompleted: {
        txt.text = getProperties(btnUpdate);
    }

    // 遍历对象所有属性
    function getProperties(obj){
        var props = "";
        for(var p in obj){
            if(typeof(obj[p]) != "function"){
                props += p + "=" + obj[p] + "\r\n";
            }
        }
        return props;
    }
}
