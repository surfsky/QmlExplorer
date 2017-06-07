import QtQuick 2.2
import QtQuick.Controls 1.1


// 测试外部链接，可调用手机的功能，如打电话
Flow {
    width: 640
    height: 480
    spacing: 10



    Button{
        text: 'web'
        onClicked: Qt.openUrlExternally("http://www.baidu.com");
    }


    Button{
        text: 'tel'
        onClicked: Qt.openUrlExternally("tel:15305770111");
    }

    Button{
        text: 'sms'
        onClicked: Qt.openUrlExternally("sms:15305770111");
    }

    Button{
        text: 'email'
        onClicked: Qt.openUrlExternally("mailto:15305770111@189.cn");
    }
}
