import QtQuick 2.0
import QtQuick.Controls 1.2

/**
Fuzzy Panel test
*/
Rectangle {
    id: root
    width: 600
    height: 600

    //
    Row{
        width:parent.width
        height: 100
        Button{text: 'actionSheet'; onClicked: {animActionSheet.start();}}
        Button{text: 'reset'; onClicked: {animReset.start();}}
    }

    // 背景
    Rectangle{
        id: panelBg
        width: 400
        height: 400
        anchors.centerIn: parent
        color: 'lightgreen'
        Image{
            id: img
            source: "bug.png"
            anchors.centerIn: parent
        }
    }

    // 毛玻璃面板
    FuzzyPanel{
        id: panel
        width: 200;
        height: 200;
        x: 200
        y: 200
        target: panelBg
    }

    //--------------------------------------------
    // Animations
    //--------------------------------------------
    SequentialAnimation{
        id: animReset
        ScriptAction{script:{
            panel.width = 200;
            panel.height = 200;
            panel.x = 100;
            panel.y = 100;
            panel.dragable = true;
        }}
    }

    SequentialAnimation{
        id: animActionSheet
        ScriptAction{script:{
            panel.width = parent.width;
            panel.height = 400;
            panel.x = 0;
            panel.y = root.height;
            panel.dragable = false;
        }}
        PropertyAnimation{
            target: panel
            properties: 'y'
            from: root.height
            to: root.height - panel.height
        }
    }

}

