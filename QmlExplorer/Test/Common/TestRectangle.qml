import QtQuick 2.0

Column {
    width: 480
    height: 640
    spacing: 10
    x: 10
    y: 10


    Rectangle {
        width: 80
        height: 80
        color: "red"
        border.color: "black"
        border.width: 0
        radius: 10
    }

    Rectangle {
        color: "#00B000"
        width: 80; height: 80
    }

    Rectangle {
        color: "steelblue"
        y: 100; width: 80; height: 80
    }

    Rectangle {
        y: 0; width: 80; height: 80
        color: "lightsteelblue"
    }

    Rectangle {
        y: 100; width: 80; height: 80
        gradient: Gradient {
            GradientStop { position: 0.0; color: "lightsteelblue" }
            GradientStop { position: 1.0; color: "blue" }
        }
    }

    Rectangle {
        y: 200; width: 80; height: 80
        rotation: 90
        gradient: Gradient {
            GradientStop { position: 0.0; color: "lightsteelblue" }
            GradientStop { position: 1.0; color: "blue" }
        }
    }
}
