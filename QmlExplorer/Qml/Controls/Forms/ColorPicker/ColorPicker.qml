import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0

/**
色彩选择框
    /先显示一个色块（并标注了颜色值）
    /可直接输入色彩值，按enter保存修改
    右侧按钮点击显示（可选）
        /系统色彩窗口
        自定义调色板窗口
协议：MIT. 请保留本协议说明
历史：
    2014-12 初版 surfsky.cnblogs.com
    2015-01 优化UI，增加自定义色彩面板 surfsky.cnblogs.com
**/

Rectangle {
    id: root
    width: 80
    height: 20
    color: '#0000ff'
    border.width: 1
    border.color: '#c0c0c0'
    radius: 4

    // 是否使用系统色彩对话框
    property bool useSystemColorDialog : false;
    property alias paletteSize : pkr.paletteSize;

    // 隐藏弹出的色彩对话框
    function hideDialog(){
        win.visible = false;
        colorDialog.visible = false;
    }



    // 获取对比色（便于文字显示）
    function getAntiColor(color){
        return Qt.rgba(1-color.r, 1-color.g, 1-color.b, 1);
    }

    // 右侧的按钮
    Rectangle{
        x: parent.width - width
        width: 20
        height: parent.height
        color: '#d0d0d0'
        radius: root.radius
        Rectangle{
            width: parent.width-parent.radius
            height: parent.height
            color: parent.color
        }
        Text{
            id:lblArrow
            text: '>'
            color: 'black'
            font.bold: true
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onPressed: lblArrow.color = 'white';
            onExited: lblArrow.color = 'black';
            onClicked: {
                if (useSystemColorDialog)
                    colorDialog.open();
                else{
                    win.visible = true;
                    pkr.color = root.color;
                }
            }
        }
    }
    // 色彩值
    TextInput{
        id: txt
        text: root.color
        color: getAntiColor(root.color)
        font.pixelSize: 12
        anchors.verticalCenter: parent.verticalCenter
        x:8
        z:2
        focus: true
        Keys.onReturnPressed: {root.color = text;}
    }

    // 自定义调色板取色器
    Item{
        id: win
        x: root.width
        y: root.height+5
        width: 150
        height: 200
        visible: false
        RectangleShadow{
            id: shadow
            z:0
            targetWidth: pkr.width
            targetHeight: pkr.height
        }
        ColorPalettePicker{
            id: pkr
            z: 1
            anchors.fill: parent
            paletteSize : Qt.size(10, 10)
            onExited: {
                win.visible = false;
                root.color = pkr.color;
            }
        }
    }


    // 色彩对话框。帮助里面是用color属性，不对，应该是currentColor。其实要么是属性弄错了，要么命名要改一下更合适。
    ColorDialog {
        id: colorDialog
        onAccepted: {
            root.color = colorDialog.currentColor;
            txt.text = colorDialog.currentColor;  //.color
        }
    }
}

