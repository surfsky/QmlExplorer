import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1


// 测试在 main.cpp 中注册的模型
// 请查看QmlExtension相关目录示例
Column {
    width: 640
    height: 480
    spacing: 10
    x: 10
    y: 10

    Models {id: models}

    // lists 在main.cpp中注册
    ListView {
        width: 200
        model: lists
    }

    // lists 在main.cpp中注册
    ListView {
        width: 200
        model: fonts
    }
}
