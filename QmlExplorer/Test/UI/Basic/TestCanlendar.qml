import QtQuick 2.2
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.1


ApplicationWindow {
    visible: true
    width: 640
    height: 400
    minimumWidth: 400
    minimumHeight: 300
    color: "#f4f4f4"

    title: "Calendar Example"


    Row {
        id: row
        anchors.fill: parent
        anchors.margins: 20
        spacing: 10


        Calendar {
            id: calendar
            width: parent.width * 0.6 - row.spacing / 2
            height: parent.height
            selectedDate: new Date(2014, 0, 1)
            focus: true
            /*
            style: CalendarStyle {
                dayDelegate: Item {
                    readonly property color sameMonthDateTextColor: "#444"
                    readonly property color selectedDateColor: Qt.platform.os === "osx" ? "#3778d0" : __syspal.highlight
                    readonly property color selectedDateTextColor: "white"
                    readonly property color differentMonthDateTextColor: "#bbb"
                    readonly property color invalidDatecolor: "#dddddd"

                    Rectangle {
                        anchors.fill: parent
                        border.color: "transparent"
                        color: styleData.date !== undefined && styleData.selected ? selectedDateColor : "transparent"
                        anchors.margins: styleData.selected ? -1 : 0
                    }

                    Image {
                        visible: eventModel.eventsForDate(styleData.date).length > 0
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.margins: -1
                        width: 12
                        height: width
                        source: "qrc:/images/eventindicator.png"
                    }

                    Label {
                        id: dayDelegateText
                        text: styleData.date.getDate()
                        font.pixelSize: 14
                        anchors.centerIn: parent
                        color: {
                            var color = invalidDatecolor;
                            if (styleData.valid) {
                                // Date is within the valid range.
                                color = styleData.visibleMonth ? sameMonthDateTextColor : differentMonthDateTextColor;
                                if (styleData.selected) {
                                    color = selectedDateTextColor;
                                }
                            }
                            color;
                        }
                    }
                }
            }
            */
        }

        Calendar {
                    id: calendar2
                    width: parent.width * 0.6 - row.spacing / 2
                    height: parent.height
                    selectedDate: new Date()
                    focus: true

                    style: CalendarStyle {
                        dayDelegate: Rectangle {//设置日期样式，使用了渐变式
                            gradient: Gradient {
                                GradientStop {
                                    position: 0.00
                                    color: styleData.selected ? "#111" : (styleData.visibleMonth && styleData.valid ? "#444" : "#666");
                                }
                                GradientStop {
                                    position: 1.00
                                    color: styleData.selected ? "#444" : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");
                                }
                                GradientStop {
                                    position: 1.00
                                    color: styleData.selected ? "#777" : (styleData.visibleMonth && styleData.valid ? "#111" : "#666");
                                }
                            }

                            Label {
                                text: styleData.date.getDate()
                                anchors.centerIn: parent
                                color: styleData.valid ? "white" : "grey"
                            }

                            Rectangle {
                                width: parent.width
                                height: 1
                                color: "#555"
                                anchors.bottom: parent.bottom
                            }

                            Rectangle {
                                width: 1
                                height: parent.height
                                color: "#555"
                                anchors.right: parent.right
                            }
                        }
                        dayOfWeekDelegate: Item{//设置周的样式
                            Rectangle{
                                anchors.fill: parent
                                Text {
                                    id: weekTxt
                                    text:Qt.locale().dayName(styleData.dayOfWeek, control.dayOfWeekFormat)//转换为自己想要的周的内容的表达
                                    anchors.centerIn: parent
                                    color: styleData.selected?"green":"gray"
                                }
                            }
                        }
                        navigationBar: Rectangle {//导航控制栏，控制日期上下选择等
                                color: "#49A9E3"
                                height: dateText.height * 4

                                Rectangle {
                                    color: Qt.rgba(1, 1, 1, 0.6)
                                    height: 1
                                    width: parent.width
                                }

                                Rectangle {
                                    anchors.bottom: parent.bottom
                                    height: 1
                                    width: parent.width
                                    color: "#ddd"
                                }
                                ToolButton {
                                    id: previousMonth
                                    width: parent.height
                                    height: width-20
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 40
                                    iconSource: "qrc:/images/left.png"
                                    onClicked: control.showPreviousMonth()
                                }
                                Label {
                                    id: dateText
                                    text: styleData.title
                                    font.pixelSize: 14
                                    font.bold: true
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                    fontSizeMode: Text.Fit
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: previousMonth.right
                                    anchors.leftMargin: 2
                                    anchors.right: nextMonth.left
                                    anchors.rightMargin: 2
                                }
                                ToolButton {
                                    id: nextMonth
                                    width: 60
                                    height: 53
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.right: parent.right
                                    anchors.rightMargin: 40
                                    iconSource: "qrc:/images/right.png"
                                    onClicked: control.showNextMonth()
                                    style: ButtonStyle {
                                            background: Item {
                                                implicitWidth: 25
                                                implicitHeight: 25
                                            }
                                        }
                                }
                            }
                    }
                }
    }
}
