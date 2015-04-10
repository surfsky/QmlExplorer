import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.0

/**
测试动态生成window对象
*/
Column{
    id: root
    width: 640
    height: 480
    spacing: 10


    // windows 对象无法用loader加载的
    Loader {id:loader}
    Button{
        text: '用loader加载window（失败）'
        onClicked: {
            loader.source = "AboutWindow.qml";
            loader.width = 300;
            loader.height = 100;
            loader.visible = true;
        }
    }

    // windows 对象可用createComponent动态创建的
    Button {
        text: '用createComponent创建window（成功）'
        onClicked:{
            var component = Qt.createComponent("AboutWindow.qml");
            var window = component.createObject(root, {});
            window.visible = true;
        }
    }

    Button{
        text: '用createQmlObject创建对话框（成功）'
        onClicked: {
            var aboutDlg = Qt.createQmlObject(
                        'import QtQuick 2.2;
                        import QtQuick.Dialogs 1.1;
                        MessageDialog{
                            icon: StandardIcon.Information;
                            title: "关于";
                            text: "对话框示例";
                            standardButtons:StandardButton.Ok;
                        }', root, "aboutDlg");
            //aboutDlg.rejected.connect(onAboutDlgClosed);
            aboutDlg.accepted.connect(function(){lblInfo.text = 'Accepted';});
            aboutDlg.visible = true;
        }
    }
}


