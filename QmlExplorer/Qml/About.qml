import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Controls 1.1


// 关于窗口
Window {
    id: root
    width: 400
    height: 200
    title: "About"
    flags: Qt.Dialog | Qt.WindowTitleHint | Qt.WindowFullscreenButtonHint | Qt.WindowCloseButtonHint
    modality: Qt.WindowModal

    Text {
        y: 20
        text: '<b>QmlExplorer</b><br/><i>A Qt QML running environment and examples explorer app.</i>.....'
        anchors.centerIn:  parent
    }
    Row{
        spacing: 10
        y: root.height - height
        width: parent.width-50
        anchors.horizontalCenter: parent.horizontalCenter
        height: 30
        Button{
            text:'max'
            onClicked: root.visibility = Window.FullScreen
        }
        Button{
            text:'min'
            onClicked: root.visibility = Window.Minimized
        }
        Button{
            text:'normal'
            onClicked: root.visibility = Window.AutomaticVisibility
        }
        Button {
            id: btnClose
            text:"Close"
            tooltip:"Press me, to close this window"
            onClicked: root.visible = false
        }
    }
}
