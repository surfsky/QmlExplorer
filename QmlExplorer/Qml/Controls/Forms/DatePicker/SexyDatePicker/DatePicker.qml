import QtQuick 1.1

/*
Copyright (c) 2011-2012, Vasiliy Sorokin <sorokin.vasiliy@gmail.com>
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:
* Redistributions of source code must retain the above copyright notice,
this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright notice,
this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
* Neither the name of the Vasiliy Sorokin nor the names of its contributors may be used to endorse or
promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS
BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Usage:
    DatePicker {
        id: datePicker

        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }

        function orientationString() {
            if (screen.currentOrientation === Screen.Portrait || screen.currentOrientation === Screen.PortraitInverted )
                return "portrait"
            else
                return "landscape"
        }

        platformStyle: DatePickerStyle {
            orientationString: datePicker.orientationString()
        }
    }

    You can use
    function setDate(currentDate) for set current selected date and
    function setEvent(eventDate, enable) for set/unset event marker (NB: Markers ca be sets only for selected mounth now)

    Also component emit signal selectedDateChanged(date selectedDate) when selected date is change
*/

Item {
    id: root

    property DatePickerStyle platformStyle: DatePickerStyle {}

    signal selectedDateChanged(date selectedDate)

    width: background.sourceSize.width
    height: background.sourceSize.height
    Item {
        id: wrapper

        x: 0
        y: 0
        width: parent.width
        height:parent.height

        clip: true

        NumberAnimation {
            id: previousMonthAnimation

            loops: 1
            target: wrapper
            running: false
            property: "x"
            from: 0
            to: wrapper.width
            duration: 75

            onCompleted: {
                wrapper.x = 0
            }
        }

        NumberAnimation {
            id: nextMonthAnimation

            loops: 1
            target: wrapper
            running: false
            property: "x"
            from: 0
            to: -wrapper.width
            duration: 75

            onCompleted: {
                wrapper.x = 0
            }
        }

        Image {
            id: background
            anchors.fill: parent
            source: root.platformStyle.backgroundImage
            Item {
                id: header

                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }

                height: 65

                Item {
                    id: leftArrow

                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                    }

                    width: 100
                    height: 65

                    Image {
                        id: leftArrowImage

                        anchors {
                            left: parent.left
                            leftMargin: (header.width / 7) / 2 - (width / 2)
                            verticalCenter: parent.verticalCenter
                        }

                        width: height
                        source: root.platformStyle.leftArrowImage
                    }

                    MouseArea {
                        anchors.fill: parent

                        onPressed: {
                            leftArrowImage.source = root.platformStyle.leftArrowPressedImage
                        }

                        onReleased: {
                            leftArrowImage.source = root.platformStyle.leftArrowImage
                            previousMonthAnimation.start()
                            dateModel.showPrevious()
                        }
                    }
                }

                Text {
                    id: monthLabel
                    anchors.centerIn: parent
                    font.pixelSize: root.platformStyle.monthFontSize
                    font.weight: Font.Light
                    color: root.platformStyle.monthColor
                }

                Item {
                    id: rightArrow

                    anchors {
                        right: parent.right
                        top: parent.top
                        bottom: parent.bottom
                    }

                    width: 100
                    height: 70

                    Image {
                        id: rightArrowImage

                        anchors {
                            right: parent.right
                            rightMargin: (header.width / 7) / 2 - (width / 2)
                            verticalCenter: parent.verticalCenter
                        }

                        width: height
                        source: root.platformStyle.rightArrowImage
                    }

                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                            rightArrowImage.source = root.platformStyle.rightArrowPressedImage
                        }

                        onReleased: {
                            rightArrowImage.source = root.platformStyle.rightArrowImage
                            nextMonthAnimation.start()
                            dateModel.showNext()
                        }
                    }
                }


            }

            Row {
                id: weekDaysGrid

                anchors {
                    left: parent.left
                    right: parent.right
                    top: header.bottom
                    bottomMargin: 10
                }

                width: parent.width

                WeekCell {
                    text: qsTr("Mon")
                    platformStyle: datePicker.platformStyle
                }
                WeekCell {
                    text: qsTr("Tue")
                    platformStyle: datePicker.platformStyle
                }
                WeekCell {
                    text: qsTr("Wed")
                    platformStyle: datePicker.platformStyle
                }
                WeekCell {
                    text: qsTr("Thu")
                    platformStyle: datePicker.platformStyle
                }
                WeekCell {
                    text: qsTr("Fri")
                    platformStyle: datePicker.platformStyle
                }
                WeekCell {
                    isWeekEnd: true
                    text: qsTr("Sat")
                    platformStyle: datePicker.platformStyle
                }
                WeekCell {
                    isWeekEnd: true
                    text: qsTr("Sun")
                    platformStyle: datePicker.platformStyle
                }
            }

            GridView {
                id: daysGrid

                anchors {
                    top: weekDaysGrid.bottom
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                }
                cellWidth: width / 7 - 1
                cellHeight: height / 6

                interactive: false

                delegate: DayCell {
                    platformStyle: datePicker.platformStyle

                    width: daysGrid.cellWidth;
                    height: daysGrid.cellHeight

                    isCurrentDay: model.isCurrentDay
                    isOtherMonthDay: model.isOtherMonthDay
                    hasEventDay: model.hasEventDay

                    dateOfDay: model.dateOfDay
                }

                model: DateModel {
                    id: dateModel
                    currentDate: new Date()

                    onMonthChanged: {
                        monthLabel.text = getMonthYearString()
                        daysGrid.currentIndex = dateModel.firstDayOffset + selectedDate.getDate() - 1
                    }

                    onSelectedDateChanged: {
                        root.selectedDateChanged(selectedDate)
                    }
                }

                MouseArea {
                    anchors.fill: parent

                    property int pressedPosition: 0

                    onPressed: {
                        pressedPosition = mouseX
                    }

                    onReleased: {
                        var delta =  mouseX - pressedPosition;
                        if (Math.abs(delta) > 100) {
                            if (delta < 0) {
                                nextMonthAnimation.start()
                                dateModel.showNext()
                            }
                            else {
                                previousMonthAnimation.start()
                                dateModel.showPrevious()
                            }
                        }
                        pressedPosition = 0

                        if (Math.abs(delta) < 20) {
                            var index = daysGrid.indexAt(mouseX, mouseY)
                            daysGrid.currentIndex = index
                            dateModel.selectedDate = daysGrid.currentItem.dateOfDay
                            if (daysGrid.currentItem.isOtherMonthDay) {
                                if (daysGrid.currentItem.dateOfDay.getMonth() < dateModel.selectedDate.getMonth())
                                    previousMonthAnimation.start()
                                else
                                    nextMonthAnimation.start()

                                dateModel.changeModel(daysGrid.currentItem.dateOfDay)
                            }
                        }
                    }
                }
            }
        }
    }
    Component.onCompleted: {
        var currentDate = new Date()
        setDate(currentDate)
    }

    function setDate(currentDate) {
        dateModel.changeModel(currentDate)
        daysGrid.currentIndex = dateModel.firstDayOffset + currentDate.getDate() - 1
    }

    function setEvent(eventDate, enable) {
        dateModel.setEvent(eventDate, enable)
    }
}
