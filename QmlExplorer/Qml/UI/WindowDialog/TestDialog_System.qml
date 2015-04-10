import QtQuick 2.0
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1


/**
测试系统对话框（消息框、文件选择框、色彩设置框、字体设置框等）
- Dialog默认是隐藏的
- 用dlg.open()打开
*/
Column {
    id: root
    width: 640
    height: 480
    spacing: 10


    //--------------------------------------
    // 控制区
    //--------------------------------------
    Row{
        width: parent.width
        spacing: 10
        Button { text: "About..." ;  onClicked: aboutBox.open() }
        Button { text: "DynamicCreate..." ; onClicked: showAbout() }
        Button { text: "Font..." ; onClicked: fontDialog.open() }
        Button { text: 'File...'; onClicked: fileDialog.open();}
        Button { text: "&Color ..."; onClicked:colorDialog.open()}
    }
    Text{
        id: lblInfo
        text: 'infomation'
        color: 'blue'
    }


    //--------------------------------------
    // 各种系统对话框
    //--------------------------------------
    MessageDialog {
        id: aboutBox
        title: "About Text"
        text: "This is a basic text editor \nwritten with Qt Quick Controls"
        icon: StandardIcon.Information
        onButtonClicked: {

        }
    }

    FileDialog {
        id: fileDialog
        nameFilters: ["Text files (*.txt)", "HTML files (*.html)", , "All files (*.*)"]
        onAccepted: lblInfo.text = fileUrl
    }

    // 色彩对话框。帮助里面是用color属性，不对，应该是currentColor。其实要么是属性弄错了，要么命名要改一下更合适。
    ColorDialog {
        id: colorDialog
        color: lblInfo.color
        onAccepted: {
            lblInfo.color = colorDialog.currentColor;  //.color
        }
    }

    // 字体对话框
    FontDialog {
        id: fontDialog
        title: "Please choose a font"
        font: lblInfo.font
        onAccepted: {
            lblInfo.font = fontDialog.font;
        }
    }

    // 用JS代码创建对话框
    property var aboutDlg;
    function showAbout(){
        if(aboutDlg == null){
            aboutDlg = Qt.createQmlObject(
                        'import QtQuick 2.2;
                        import QtQuick.Dialogs 1.1;
                        MessageDialog{
                            icon: StandardIcon.Information;
                            title: "关于";
                            text: "仅仅是个示例";
                            standardButtons:StandardButton.Ok;
                        }', root, "aboutDlg");
            //aboutDlg.rejected.connect(onAboutDlgClosed);
            aboutDlg.accepted.connect(function(){lblInfo.text = 'Accepted';});
            aboutDlg.visible = true;
        }
    }

}
