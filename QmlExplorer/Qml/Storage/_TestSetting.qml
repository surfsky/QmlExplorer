import QtQuick 2.1
import QtQuick.Controls 1.2
import Qt.labs.settings 1.0


/**
settings 组件测试
跨平台序列化存储方案
*/
Rectangle{
    id: page
    states: [
        State {
            name: "active"
            // ...
        },
        State {
            name: "inactive"
            // ...
        }
    ]

    Switch{
        checked: true

    }

    // settings
    Settings {
        id: settings
        property string state: "active"
    }
    state: settings.state
    Component.onDestruction: {
        settings.state = page.state
    }
}
