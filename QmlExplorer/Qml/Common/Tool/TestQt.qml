import QtQuick 2.2
import QtQuick.Controls 1.1

Grid{
    x:10
    y:10
    spacing: 10
    columns: 2

    //---------------------------------------------
    // property
    //---------------------------------------------
    Text{text: "Qt.application.name"}
    Text{text: Qt.application.name}

    Text{text: "Qt.application.organization"}
    Text{text: Qt.application.organization}

    Text{text: "Qt.application.version"}
    Text{text: Qt.application.version + "  "}


    Text{text: "Qt.application.layoutDirection"}
    Text{text: Qt.application.layoutDirection}

    Text{text: "Qt.application.active"}
    Text{text: Qt.application.active}


    Text{text: "Qt.platform.os"}
    Text{text: Qt.platform.os}


    //---------------------------------------------
    // function
    //---------------------------------------------
    Text{text: 'Qt.md5("hello, world")'}
    Text{text: Qt.md5("hello, world")}

    Text{text: 'Qt.atob("hello, world")'}
    Text{text: Qt.atob("hello, world")}

    Text{text:  "Qt.lighter(Qt.rgba(1, 0, 0, 1))"}
    Text{text: "color"; color:Qt.lighter(Qt.rgba(1, 0, 0, 1))}

    Text{text: "Qt.resolvedUrl"}
    Text{text: Qt.resolvedUrl("../Controls/Cell.qml")}

    Text{text: "Qt.openUrlExternally"}
    Button {text: "go"; onClicked:{
            Qt.openUrlExternally(Qt.resolvedUrl("../Controls/Cell.qml"))
        }
    }

    Text{text: "Qt.openUrlExternally-http"}
    Button{
        text: 'web'
        onClicked: Qt.openUrlExternally("http://www.baidu.com");
    }

    Text{text: "Qt.openUrlExternally-tel"}
    Button{
        text: 'tel'
        onClicked: Qt.openUrlExternally("tel:15305770111");
    }

    Text{text: "Qt.quit"}
    Button {
        text: "quit";
        onClicked: Qt.quit();
    }
}
