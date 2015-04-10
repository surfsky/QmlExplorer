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


This file is a part of DatePicker component.
*/

Item {
    id: dayCell
    property QtObject platformStyle: DatePickerStyle {}
    property bool isOtherMonthDay: false
    property bool isCurrentDay: false
    property bool isSelectedDay: false
    property bool hasEventDay: false

    property date dateOfDay

    function color() {
        if (GridView.isCurrentItem)
            return platformStyle.selectedDayColor
        else if (isCurrentDay)
            return platformStyle.currentDayColor
        else if (isOtherMonthDay)
            return platformStyle.otherMonthDayColor
        return platformStyle.dayColor
    }

    function background() {
        if (GridView.isCurrentItem) {
            if (isCurrentDay)
                return platformStyle.currentSelectedDayImage
            return platformStyle.selectedDayImage
        }
        else if (isCurrentDay)
            return platformStyle.currentDayImage
        return ""
    }

    function eventImage() {
        if (GridView.isCurrentItem)
            return platformStyle.selectedDayEventImage
        else if (dateOfDay.getDay() === 0 || dateOfDay.getDay() === 6)
            return platformStyle.weekEndEventImage
        else if (isCurrentDay)
            return platformStyle.currentDayEventImage
        else if (isOtherMonthDay)
            return platformStyle.otherMonthEventImage
        return platformStyle.eventImage
    }

    Image {
        id: background
        anchors.centerIn: parent

        source: dayCell.background()
        Text {
            id: label
            anchors.centerIn: parent
            font.pixelSize: dayCell.platformStyle.dayFontSize
            color: dayCell.color()
            font.weight: (dayCell.isCurrentDay || dayCell.GridView.isCurrentItem) ? Font.Bold : Font.Light
            text: dayCell.dateOfDay.getDate()
        }
        Image {
            anchors {
                top: label.bottom
                topMargin: -5
                horizontalCenter: parent.horizontalCenter
            }

            visible: hasEventDay
            source: dayCell.eventImage()
        }
    }
}
