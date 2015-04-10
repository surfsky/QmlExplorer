import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Window 2.1

Grid{
    x:10
    y:10
    spacing: 10
    columns: 2


    Text{text: "Screen.width"}
    Text{text: Screen.width}

    Text{text: "Screen.height"}
    Text{text: Screen.height}

    Text{text: "Screen.orientation"}
    Text{text: Screen.orientation}

    Text{text: "Screen.primaryOrientation"}
    Text{text: Screen.primaryOrientation}

    Text{text: "Screen.pixelDensity"}
    Text{text: Screen.pixelDensity}

    Text{text: "Screen.name"}
    Text{text: Screen.name}

    Text{text: "Screen.desktopAvailableWidth"}
    Text{text: Screen.desktopAvailableWidth}

    Text{text: "Screen.desktopAvailableHeight"}
    Text{text: Screen.desktopAvailableHeight}
}
