import QtQuick 2.0
import QtQuick.Controls 1.1


/**
测试StackView，基于堆栈的视图集合，可返回
    /控制前进动画（delegate）
    控制回退动画
*/
Rectangle {
    id: root
    width: 640
    height: 480

    // 当前页面
    property var urls : ["../Page1.qml", "../Page2.qml", "../Page3.qml"];
    property int i : 0;

    // 辅助方法
    function checkView()
    {
        btnBack.enabled = (stackView.depth > 1);
    }
    function getDelegate(){
        var txt = cmbType.currentText;
        if (txt == 'rotation') return rotationDelegate;
        if (txt == 'bounce')   return bounceDelegate;
        if (txt == 'roll')     return rollDelegate;
        if (txt == 'page')     return pageDelegate;
        else                   return 'undefined';   //// 如何取消代理？
    }



    //------------------------------------------
    // 控制区
    //------------------------------------------
    Row{
        id: toolbar
        height: 30
        spacing: 10
        ComboBox {
            id: cmbType
            width:120
            model: ["rotation", "bounce", "roll", "page", "default"]
            anchors.verticalCenter: parent.verticalCenter
            x: 10
        }
        Button {
            id: btnBack
            text: 'back'
            enabled: false
            anchors.verticalCenter: parent.verticalCenter
            onClicked:{
                stackView.delegate = getDelegate();
                stackView.pop();
                checkView();
            }
        }
        Button{
            id: btnAdd
            text: "add"
            anchors.verticalCenter: parent.verticalCenter
            onClicked:{
                i = (i+1)%3;
                stackView.delegate = getDelegate();
                stackView.push(Qt.resolvedUrl(urls[i]));
                checkView();
            }
        }
        Text{
            id: text
            text: stackView.depth
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    //------------------------------------------
    // 堆栈视图
    //------------------------------------------
    StackView {
        id: stackView
        y: toolbar.height
        initialItem: Qt.resolvedUrl("../Page1.qml")
        delegate: rotationDelegate  // 进场出场动画代理
        clip: false
    }

    // 弹跳进出场动画代理
    StackViewDelegate {
        id: bounceDelegate
        pushTransition: StackViewTransition {
            PropertyAnimation {target: enterItem; property: "x"; from: enterItem.width; to: 0; easing.type: Easing.OutBounce}
            PropertyAnimation {target: exitItem; property: "x"; from: 0; to: -exitItem.width; easing.type: Easing.OutBounce}
        }
        popTransition: StackViewTransition {
            PropertyAnimation {target: enterItem; property: "x"; from: -enterItem.width; to: 0; easing.type: Easing.OutBounce}
            PropertyAnimation {target: exitItem; property: "x"; from: 0; to: exitItem.width; easing.type: Easing.OutBounce}
        }
    }

    // 旋转进出场动画代理
    StackViewDelegate {
        id: rotationDelegate
        pushTransition: StackViewTransition {
            SequentialAnimation {
                ScriptAction {script: enterItem.rotation = 90}
                PropertyAnimation {target: enterItem; property: "x"; from: enterItem.width; to: 0}
                PropertyAnimation {target: enterItem; property: "rotation"; from: 90; to: 0}
            }
            PropertyAnimation {target: exitItem; property: "x"; from: 0; to: -exitItem.width}
        }
        popTransition: StackViewTransition {
            SequentialAnimation {
                ScriptAction {script: enterItem.rotation = -90}
                PropertyAnimation {target: enterItem; property: "x"; from: -enterItem.width; to: 0}
                PropertyAnimation {target: enterItem; property: "rotation"; from: -90; to: 0}
            }
            PropertyAnimation {target: exitItem; property: "x"; from: 0; to: exitItem.width}
        }
    }


    // 翻卡效果的进出场（左上角旋转）
    StackViewDelegate {
        id: rollDelegate
        pushTransition: StackViewTransition {
            SequentialAnimation {
                ScriptAction {script: {
                    enterItem.transformOrigin = Item.TopLeft;
                    enterItem.rotation = 90;
                }}
                PropertyAnimation {target: enterItem; property: "rotation"; to: 0}
            }
        }
        popTransition: StackViewTransition {
            SequentialAnimation {
                ScriptAction {script: {
                    enterItem.x = 0;
                    enterItem.rotation = 0;
                    exitItem.transformOrigin = Item.TopLeft;
                    exitItem.rotation = 0;
                }}
                PropertyAnimation {target: exitItem; property: "rotation"; to: 90}
            }
        }
    }



    // 翻书效果的进出场（左侧翻书）
    StackViewDelegate {
        id: pageDelegate
        property Rotation rot : Rotation{
            axis { x: 0; y: 1; z: 0 }
            origin.x: 0
            origin.y: 0
        }
        pushTransition: StackViewTransition {
            SequentialAnimation {
                ScriptAction {script: {
                    exitItem.x = 0;
                    exitItem.transform = null;
                    enterItem.transform = pageDelegate.rot;
                    pageDelegate.rot.angle = 90;
                }}
                PropertyAnimation {target: pageDelegate.rot; property: "angle"; to: 0}
            }
        }
        popTransition: StackViewTransition {
            SequentialAnimation {
                ScriptAction {script: {
                    enterItem.x = 0;
                    enterItem.transform = null;
                    exitItem.transform = pageDelegate.rot;
                    pageDelegate.rot.angle = 0;
                }}
                PropertyAnimation {target: pageDelegate.rot; property: "angle"; to: 90}
            }
        }
    }
}
