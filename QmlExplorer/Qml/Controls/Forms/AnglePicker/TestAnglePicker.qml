import QtQuick 2.10


Grid {
    spacing: 20
    rows: 8; columns: 6

    AnglePicker{ id : pkr}
    Text{ text: pkr.angle; }
    Text{ text: Math.round(360.0 * pkr.angle  / Math.PI / 2) }
}
