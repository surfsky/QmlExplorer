import QtQuick 2.4
import QtQuick.Controls 1.1


/**
测试 OpenGLInfo
*/
Grid{
    x:10
    y:10
    spacing: 10
    columns: 2
    Text{text: "majorVersion"}
    Text{text: OpenGLInfo.majorVersion}

    Text{text:  "minorVersion"}
    Text{text: OpenGLInfo.minorVersion}

    Text{text: "profile"}
    Text{text: OpenGLInfo.profile}

    Text{text: "renderableType "}
    Text{text: OpenGLInfo.renderableType }
}
