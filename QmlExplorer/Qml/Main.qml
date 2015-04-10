import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.0


/**
测试Application Window
- 有标题、菜单、工具栏、状态栏、上下文菜单
- 适合传统桌面程序，
- 现代的程序（如360）都是自绘的，或者是ribbon的
- 所以说这种 ApplicationWindow 已经不太合适了
*/
ApplicationWindow {
    id: root
    width: 800
    height: 600
    title: 'application window'

    // menu, toobar, status
    menuBar: MenuBar {
        Menu {
            id: menuFile
            title: "File"
            MenuItem { text: "Open..." }
            MenuItem { text: "Close" }
        }

        Menu {
            title: "Edit"
            MenuItem { text: "Cut" }
            MenuItem { text: "Copy" }
            MenuItem { text: "Paste" }
        }
    }
    toolBar: ToolBar {
        RowLayout {
            ToolButton {text: 'quit'; onClicked: Qt.quit();}
            ToolButton {text: 'button2'}
            ToolButton {text: 'button3'}
        }
    }
    statusBar: StatusBar {
        RowLayout {
            Label { text: "Read Only" }
        }
    }

    // context menu
    Menu {
        id: menuContext
        title: "File"
        MenuItem { text: "Open..." }
        MenuItem { text: "Close" }
    }

    Splash{
        onTimeout: root.visible = true;
    }

    // main area
    Rectangle{
        anchors.fill: parent
        color: 'lightBlue'

        Text{
            anchors.centerIn: parent
            text: 'hello window'
        }

        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            onClicked:{
                menuContext.popup();
            }
        }
    }
}
