import QtQuick 2.0

Grid {
    x: 20; y:20
    width: 800
    height: 600
    spacing: 10
    columns: 2

    Panel{
        title: 'panel1'
        content: Rectangle{
            anchors.fill: parent
            color: 'lightyellow'
        }
    }

    Panel{
        title: 'panel2'
        headColor: '#f0f0f0'
        content: Rectangle{
            anchors.fill: parent
            color: 'lightgreen'
        }
    }

    Panel{
        title: 'panel3'
        content: Rectangle{
            anchors.fill: parent
            color: 'white'
        }
    }

    Panel{
        title: 'panel4'
        content: Rectangle{
            anchors.fill: parent
            color: 'lightpink'
        }
    }

}
