import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1

/**
测试SplitView，带layout逻辑
感觉layout很罗嗦
*/
RowLayout {
    width: 640
    height: 480

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal

        SplitView{
            width: 200
            orientation: Qt.Vertical
            Layout.maximumWidth: 400

            Rectangle {
                height: parent.height * 0.4
                Layout.minimumHeight: parent.height * 0.1
                Layout.maximumHeight: parent.height * 0.8
                color: "lightblue"
            }
            Rectangle {
                Layout.fillHeight: true
                color: "lightgreen"
            }
        }

        Rectangle {
            id: centerItem
            Layout.minimumWidth: 50
            Layout.fillWidth: true
            color: "darkgray"
        }
        Rectangle {
            width: 200
            color: "gray"
        }
    }
}
