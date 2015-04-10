import QtQuick 2.0
import QtQuick.Controls 1.2
import "date.js" as DateHelper


/**
Date.js 测试
*/
Column {
    width: 300
    height: 300
    spacing: 5

    Text{text: 'Date 操作测试'}
    Text{text: new Date().toLocaleString();}
    Text{text: "leapYear: " + (new Date()).isLeapYear();}

    // 用qt提供的辅助格式化函数
    Text{text: "Qt.formatDateTime: " + Qt.formatDateTime(new Date(), 'yyyy-MM-dd hh:mm:ss.zzz');}
    Text{text: "Qt.formatDate: " + Qt.formatDate(new Date(), 'yyyy-MM-dd');}
    Text{text: "Qt.formatTime: " + Qt.formatTime(new Date(), 'hh:mm:ss.zzz');}
}
