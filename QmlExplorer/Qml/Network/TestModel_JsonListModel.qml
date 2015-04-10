import QtQuick 2.0
import QtQuick.Controls 1.2

/**
测试JsonListModel组件
**/
Column {
    width: 600
    height: 400
    spacing: 10


    JsonListModel{
        id: json
        source: "http://wthrcdn.etouch.cn/weather_mini?city=%E5%8C%97%E4%BA%AC"
        path: ".data.forecast"
        onLoadStart: txt.text="loading";
        onLoadCompleted: txt.text="ok";
    }

    Text{id:txt}
    ListView{
        width: parent.width
        height: 300
        model: json
        delegate: Row{
            width: parent.width
            height: 20
            spacing: 5
            Text{text:date}
            Text{text:fengxiang}
            Text{text:fengli}
            Text{text:type}
            Text{text:low}
            Text{text:high}
        }
    }
}
