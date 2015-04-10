/**
测试Date对象
Qml中用的是标准的js date对象
*/

import QtQuick 2.0
import QtQml 2.2


QtObject {
    Component.onCompleted: {
        var d = new Date();
        var h = d.getHours();
        var m = d.getMinutes();
        var s = d.getSeconds();
        console.log('%d:%d:%d', h, m, s); // fail
        console.log(h + ' : ' + m + ' : ' + s);


        // time 解析示例
        var locale = Qt.locale();
        var currentTime = new Date();
        var timeString = currentTime.toLocaleTimeString(locale, Locale.ShortFormat);
        var dt = Date.fromLocaleTimeString(locale, timeString, Locale.ShortFormat);
        print(dt);
    }
}
