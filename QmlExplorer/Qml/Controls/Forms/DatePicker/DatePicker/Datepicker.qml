import QtQuick 2.0
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.0
import QtQuick.Window 2.1
import "DateUtils.js" as DateUtils

/*!
    \qmltype Datepicker
    \brief Datepicker es un control que yo hice :3
*/
Item {
    id: datepicker
    height: Math.min(dateField.height, dropdown.height)

    property date selectedDate : new Date()
    property Window activeWindow
    property var pos : getOffset(dateField)

    signal dateChanged (date date)

    /*!
      \qmlmethod Datepicker::getOffset( var item )

      Determines the absolute position of the calendar window.
    */
    function getOffset(item) {
        var offset = {
            "x": activeWindow.x + item.x,
            "y": activeWindow.y + item.y + item.height
        };
        while(item.parent) {
            item = item.parent;
            offset.x += item.x;
            offset.y += item.y;
        }
        //console.debug("total", "x", offset.x, "y", offset.y)

        return offset;
    }

    /*!
      \qmlmethod Datepicker::showModal()
      Toogle between show or hide the window with the calendar
    */
    function toggleModal() {
        if(modal.active)
            loseFocus();
        else
        {
            modal.show()
            modal.requestActivate()
        }
    }

    /*!
      \qmlmethod Datepicker::loseFocus( Date newDate )
      Sets the actual date, close the modal window.
    */
    function loseFocus(newDate) {
        if (newDate instanceof Date)
        {
            selectedDate = newDate;
            calendar.selectedDate = selectedDate;
            dateField.text = calendar.selectedDateText;
            dateChanged(newDate);
        }
        else
            calendar.selectedDate.setDate(selectedDate.getDate());

        modal.close();
        activeWindow.requestActivate();
    }

    TextField {
        id: dateField
        readOnly: true
        anchors.left: parent.left
        anchors.right: dropdown.left
        Layout.fillWidth: true
    }
    Button {
        id: dropdown
        text: "▾"
        width: 25
        anchors.leftMargin: 0
        anchors.right: parent.right

        onClicked: toggleModal()
    }
    Window {
        id: modal
        //modality: Qt.ApplicationModal
        flags: Qt.SplashScreen
        minimumHeight: calendar.height; minimumWidth: calendar.width
        maximumHeight: calendar.height; maximumWidth: calendar.width
        x: pos.x
        y: pos.y

        Calendar {
            id: calendar
            selectedDateFormat: "dd MMMM yyyy"
            onDoubleClicked: loseFocus(calendar.selectedDate)
            onEscapePressed: loseFocus()
        }
    }
    Component.onCompleted: loseFocus(calendar.selectedDate)
    //onDateChanged: console.debug("me quieren cambiar por", date) //calendar.selectedDate = selectedDate
}

