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

ListModel {
    id: dateModel

    signal monthChanged()

    property int firstDayOffset: 0
    property date selectedDate: new Date()
    property date currentDate: new Date()

    //public:
    function setEvent(eventDate, enable) {
        if (eventDate.getMonth() !== selectedDate.getMonth() && eventDate.getFullYear() !== selectedDate.getFullYear())
            return
        setProperty(eventDate.getDate() + firstDayOffset, "hasEventDay", enable)
    }

    function getMonthYearString() {
        return Qt.formatDate(selectedDate, "MMMM yyyy")
    }

    function changeModel(_selectedDate) {
        clear()
        selectedDate = _selectedDate

        fillModel()
        monthChanged()
    }

    function showNext() {
        showOtherMonth(selectedDate.getMonth() + 1)
    }

    function showPrevious() {
        showOtherMonth(selectedDate.getMonth() - 1)
    }

    //private:
    function fillModel() {
        firstDayOffset = getFirstDayOffset(selectedDate)
        for(var i = 0; i < 6 * 7; ++i) {
            var objectDate = selectedDate;
            objectDate.setDate(selectedDate.getDate() - (selectedDate.getDate() - 1 + firstDayOffset - i))
            appendDayObject(objectDate)
        }
    }

    function appendDayObject(dateOfDay) {

        append({
                   "dateOfDay" : dateOfDay,
                   "isCurrentDay" : dateOfDay.getDate() === currentDate.getDate() &&
                                    dateOfDay.getMonth() === currentDate.getMonth() &&
                                    dateOfDay.getFullYear() === currentDate.getFullYear(),
                   "isOtherMonthDay" : dateOfDay.getMonth() !== selectedDate.getMonth(),
                   "hasEventDay" : false
               })
    }

    function showOtherMonth(month) {
        var newDate = selectedDate
        var currentDay = selectedDate.getDate()
        currentDay = getValidDayByMonthAndDay(month, currentDay, isLeapYear(selectedDate.getFullYear()));
        newDate.setMonth(month, currentDay)
        changeModel(newDate)
    }

    function getFirstDayOffset(currentDate) {
        var tmpDate = currentDate
        tmpDate.setDate(currentDate.getDate() - (currentDate.getDate() - 1))
        var firstDayWeekDay = tmpDate.getDay()
        if (firstDayWeekDay === 0)
            firstDayWeekDay = 6
        else
            firstDayWeekDay--
        return firstDayWeekDay
    }

    function getValidDayByMonthAndDay(month, day, leapYear) {
        if (month === 12)
            month = 0
        if (month === -1)
            month = 11

        if (month === 0 ||
                month === 2 ||
                month === 4 ||
                month === 6 ||
                month === 7 ||
                month === 9 ||
                month === 11)
            return day

        if (month !== 1) {
            if (day < 31)
                return day
            return 30
        }

        if (day < 29)
            return day

        if (leapYear)
            return 29
        return 28
    }

    function isLeapYear(year) {
        if(year % 4 === 0) {
            if(year % 100 === 0) {
                if(year % 400 === 0) {
                    return true;
                }
                else
                    return false;
            }
            else
                return true;
        }
        return false;
    }
}
