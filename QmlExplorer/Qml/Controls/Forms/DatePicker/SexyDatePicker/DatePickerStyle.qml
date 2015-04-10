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
* Neither the name of the vsorokin nor the names of its contributors may be used to endorse or
promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS
BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


This file is a part of Datepicker component.
*/

QtObject {
    id: style

    property string orientationString: "portrait"
    property string backgroundImage: "image://theme/meegotouch-calendar-monthgrid-background-" + orientationString
    property string currentDayImage: "image://theme/meegotouch-monthgrid-daycell-current-day-" + orientationString
    property string selectedDayImage: "image://theme/meegotouch-monthgrid-daycell-selected-day-" + orientationString
    property string currentSelectedDayImage: "image://theme/meegotouch-monthgrid-daycell-selected-day-current-" + orientationString

    property string leftArrowImage: "image://theme/meegotouch-calendar-monthgrid-previousbutton"
    property string leftArrowPressedImage: "image://theme/meegotouch-calendar-monthgrid-previousbutton-pressed"
    property string rightArrowImage: "image://theme/meegotouch-calendar-monthgrid-nextbutton"
    property string rightArrowPressedImage: "image://theme/meegotouch-calendar-monthgrid-nextbutton-pressed"


    property string eventImage: "image://theme/meegotouch-monthgrid-daycell-regular-day-eventindicator"
    property string weekEndEventImage: "image://theme/meegotouch-monthgrid-daycell-regular-weekend-day-eventindicator"
    property string currentDayEventImage: "image://theme/meegotouch-monthgrid-daycell-current-day-eventindicator"
    property string selectedDayEventImage: "image://theme/meegotouch-monthgrid-daycell-selected-day-eventindicator"
    property string otherMonthEventImage: "image://theme/meegotouch-monthgrid-daycell-othermonth-day-eventindicator"

    property color weekEndColor: "#EF5500"
    property color weekDayColor: "#8C8C8C"
    property color otherMonthDayColor: "#8C8C8C"
    property color dayColor: "#000000"
    property color monthColor: "#000000"
    property color currentDayColor: "#EF5500"
    property color selectedDayColor: "#FFFFFF"

    property int monthFontSize: 32
    property int dayNameFontSize: 18
    property int dayFontSize: 26
}
