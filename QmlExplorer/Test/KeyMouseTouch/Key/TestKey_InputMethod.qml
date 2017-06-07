import QtQuick 2.1

FocusScope {
    id: textfield

    property alias text: textInput.text
    property alias placeholderText: placeholder.text
    property alias echoMode: textInput.echoMode
    signal accepted

    activeFocusOnTab: true

    implicitHeight: Math.round(40 * scaleFactor)
    implicitWidth: Math.round(parent.width)

    Rectangle {
        anchors.fill: editbg
        radius: editbg.radius
        color: "#aaffffff"
        anchors.bottomMargin: -1
    }

    Rectangle {
        id: editbg
        anchors.fill: parent
        radius: height/2
        border.width: intScaleFactor
        border.color: "#999"

        gradient: Gradient {
            GradientStop {color: "#eee" ; position: 0}
            GradientStop {color: "white" ; position: 0.1}
            GradientStop {color: "white" ; position: 1}
        }

        TextInput{
            id: textInput
            anchors.fill: parent
            clip: true
            anchors.leftMargin: 16 * scaleFactor
            anchors.rightMargin: 16 * scaleFactor
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 22 * scaleFactor
            focus: true
            onAccepted: textfield.accepted()
            Text {
                id: placeholder
                anchors.fill: parent
                verticalAlignment: Text.AlignVCenter
                visible: !(parent.text.length || textInput.inputMethodComposing)
                font: parent.font
                color: "#aaa"
            }
        }
    }

    onAccepted: {
        Qt.inputMethod.commit();
        Qt.inputMethod.hide();
    }
}

