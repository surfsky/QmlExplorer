import QtQuick 2.0

Item {
    height: 480
    width: 320
    LauncherList {
        id: ll
        anchors.fill: parent
        Component.onCompleted: {
            addExample("Example1", "Example1 description", Qt.resolvedUrl("example1.qml"));
            addExample("Example2", "Example2 description", Qt.resolvedUrl("example2.qml"));
        }
    }
}
