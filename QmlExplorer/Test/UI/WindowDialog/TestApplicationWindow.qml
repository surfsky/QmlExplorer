import QtQuick 2.3
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.0
import QtQuick.Controls.Styles 1.3

/**
测试Application Window
- 传统桌面程序窗口：有标题、菜单、工具栏、状态栏、上下文菜单
- 现代的程序（如360）无外框、菜单和工具栏，这种ApplicationWindow不适合
*/
ApplicationWindow {
    width: 800
    height: 600
    title: 'application window'

    // 菜单栏
    menuBar: MenuBar {
        Menu {
            id: menuFile
            title: "File"
            MenuItem { text: "Open..."; iconSource: 'folder.png'; shortcut: StandardKey.Open}
            MenuSeparator{}
            MenuItem { text: "Quit"; onTriggered: Qt.quit() }
        }
    }

    // 工具栏
    toolBar: ToolBar {
        width: parent.width
        RowLayout {
            width: parent.width
            ToolButton {text: 'open'; iconSource: 'folder.png'; tooltip: 'open'}
            ToolButton {text: 'quit'; iconSource: 'close.png'; tooltip:'quit'; onClicked: Qt.quit();}
            Item { Layout.fillWidth: true }
            CheckBox {text: "Enabled"; checked: true}
        }
    }

    // 状态栏
    statusBar: StatusBar {
        RowLayout {
            Label { text: "Read Only" }
        }
    }

    // 上下文菜单
    Menu {
        id: menuContext
        title: "File"
        MenuItem { text: "Open..." }
        MenuItem { text: "Close" }
    }

    //----------------------------------------
    // 主区域
    // contentItem default
    //----------------------------------------
    Rectangle{
        anchors.fill: parent
        color: 'lightBlue'

        Text{
            anchors.centerIn: parent
            text: 'hello application window'
        }

        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            onClicked:{
                menuContext.popup();
            }
        }
    }


    //----------------------------------------
    // style
    //----------------------------------------
    /*
    style: ApplicationWindowStyle {
        background: BorderImage {
            source: "background.png"
            border { left: 20; top: 20; right: 20; bottom: 20 }
        }
    }
    */
}
