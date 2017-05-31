import QtQuick 2.0

Grid {
    x: 20; y:20
    width: 800
    height: 600
    spacing: 10
    columns: 2

    CollapsablePanel{
        title: 'panel1'
        content: Rectangle{
            anchors.fill: parent
            color: 'lightyellow'
        }
    }

    CollapsablePanel{
        title: 'panel2'
        headColor: '#f0f0f0'
        content: Rectangle{
            anchors.fill: parent
            color: 'lightgreen'
        }
    }

    CollapsablePanel{
        title: 'panel3'
        content: Rectangle{
            anchors.fill: parent
            color: 'white'
        }
    }

    CollapsablePanel{
        title: 'panel4'
        content: Rectangle{
            anchors.fill: parent
            color: 'lightpink'
        }
    }

}
