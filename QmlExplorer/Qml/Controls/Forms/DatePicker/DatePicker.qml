import QtQuick 2.0

/**
一个textbox
一个图标
点击弹出calendar
选择后设置textbox

*/

Rectangle {
    id: root
    color: "transparent"
    width: 300
    height: 40
    property var _monthNames: [ "JAN", "FEB", "MAR", "APR", "MAY", "JUN","JUL", "AUG", "SEP", "OCT", "NOV", "DEC" ];
    property var date: new Date()

    onDateChanged: {
        month.text = root._monthNames[root.date.getMonth()];
        day.text = date.getDate();
        year.text = date.getFullYear();
    }
    Row {
        spacing: 4
        anchors.fill: parent

        Rectangle {
            height: root.height
            width: root.width/3 - 20
            color: "#272822"
            border.color: "#76644A"
            border.width: 1
            radius: 2
            antialiasing: true

            TextInput {
                id: month
                anchors.centerIn: parent
                color: "#ecc089"
                font.pointSize: 25
                font.bold: true
                text: root._monthNames[root.date.getMonth()]
                onAccepted: {
                    for (var i = 0; i < 12; i++) {
                        if (text === root._monthNames[i]) {
                            root.date.setMonth(i);
                            root.date = root.date;
                            return;
                        }
                    }
                    root.date = root.date;
                }
            }
        }

        Rectangle {
            height: root.height
            width: root.width/3 - 20
            color: "#272822"
            border.color: "#76644A"
            border.width: 1
            radius: 2
            antialiasing: true

            TextInput {
                id: day
                anchors.centerIn: parent
                color: "#ecc089"
                font.pointSize: 25
                font.bold: true
                text: root.date.getDate()
                validator:IntValidator {bottom: 1; top: 31}
                onAccepted: { root.date.setDate(text); root.date = root.date;}
            }
        }

        Rectangle {
            height: root.height
            width: root.width/3 - 20
            color: "#272822"
            border.color: "#76644A"
            border.width: 1
            radius: 2
            antialiasing: true

            TextInput {
                id: year
                anchors.centerIn: parent
                color: "#ecc089"
                font.pointSize: 25
                font.bold: true
                text: root.date.getFullYear()
                validator: IntValidator {bottom: 1995; top: (new Date()).getFullYear()}
                onAccepted:{ root.date.setFullYear(text); root.date = root.date;}
            }
        }
    }
}
