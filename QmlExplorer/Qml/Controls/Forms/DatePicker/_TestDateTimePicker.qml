import QtQuick 2.0
import QtQuick.Controls 1.2

Column {
    width: 800
    height: 600
    spacing: 10

    Row{
        Button{
            text: '设置'
            onClicked: picker.setValue(new Date())
        }
        Button{
            text: '获取'
            onClicked: {
                var dt = picker.getValue();
                lblInfo.text = dt.toLocaleDateString() + " " + dt.toLocaleTimeString();
            }
        }
        CheckBox{
            text: '显示时间'
            onCheckedChanged: {
                picker.showTime = checked;
            }
        }

        Text {id: lblInfo}
        spacing: 10
    }


    DateTimePicker{
        id: picker
        width: parent.width
    }
}
