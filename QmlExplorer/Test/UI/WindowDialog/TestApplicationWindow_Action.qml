import QtQuick 2.3
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.1


/**
菜单测试(MenuBar & ToolBar & Action)
*/
ApplicationWindow {
    width: 640
    height: 480


    // 菜单栏
    menuBar: MenuBar {
        Menu {
            title: "&File"
            MenuItem { action: fileOpenAction }
        }
    }

    // 工具栏
    toolBar: ToolBar {
        RowLayout {
            ToolButton { action: fileOpenAction}
        }
    }

    // Action： 是text、icon、event、shortcut的组合，可被menu和toolbar共用
    Action {
        id: fileOpenAction
        iconSource: "folder.png"
        text: "Open"
        shortcut: StandardKey.Copy
        onTriggered: lblInfo.text='open'
    }

    // 显示区域
    Text{
        id: lblInfo
        anchors.centerIn: parent
        text: 'Test Action'
    }
}
