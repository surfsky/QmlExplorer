import QtQuick 2.0
import QtQuick.Controls 1.2
import "ajax.js" as Ajax

/**
测试用ajax 获取 json 数据
更复杂的ajax调用请查看 qml/network/ 相关示例
几个相关天气接口
    中国天气网（json）
        http://m.weather.com.cn/atad/101230201.html         // 当日及预告（经常坏）
        http://www.weather.com.cn/data/sk/101010100.html    // 实况天气
    中华万年历（json）
        http://wthrcdn.etouch.cn/weather_mini?city=北京
    雅虎的天气信息(xml)
        https://developer.yahoo.com/weather/
        http://weather.yahooapis.com/forecastrss?w=2132582
        http://weather.yahooapis.com/forecastrss?w=15015432&u=c
        https://weather.yahoo.com/china/zhejiang/wenzhou-2132582/
*/

Column{
    width: 600
    height: 400
    spacing: 10

    //----------------------------------------
    // GET
    //----------------------------------------
    Text{text: 'AJAX示例。更复杂的ajax调用请查看 qml/network/ 相关示例'}
    Text{text: '【Get示例（获取天气）】'}
    Button{
        text: '获取天气'
        onClicked:{
            // 中国天气网当天及预告天气接口（可用）
            Ajax.get("http://www.weather.com.cn/data/sk/101010100.html",
                function(result, json){
                    city.text = json.weatherinfo.city;
                    date.text = json.weatherinfo.time;
                    temp1.text = json.weatherinfo.temp;
                }
            );
            /*
            // 中华万年历的当天及预告天气接口（可用）
            Ajax.get("http://wthrcdn.etouch.cn/weather_mini?city=%E5%8C%97%E4%BA%AC",
                function(result, json){
                    city.text = json.data.city;
                    date.text = json.data.forecast[0].date;
                    temp1.text = json.data.wendu;
                }
            );
            */
        }
    }
    Grid{
        width: parent.width
        height: 100
        spacing: 10
        columns: 2
        Text {text: 'city:'}
        Text {id:city; text:' '; width:parent.width; wrapMode: Text.WrapAnywhere; lineHeight: 1.1}
        Text {text: 'date:'}
        Text {id:date; text:' '}
        Text {text: 'temp:'}
        Text {id:temp1; text:' '}
    }


    //----------------------------------------
    // POST
    //----------------------------------------
    Text{text:'【Post示例（百度翻译）】'}
    Row{
        width: parent.width
        height: 50
        spacing: 5
        TextField{
            id: txtRaw
            text: 'hello'
            placeholderText: '请输入'
        }
        Button{
            text: '获取翻译结果'
            onClicked:{
                var raw = txtRaw.text;
                // 百度翻译接口（可用）
                Ajax.post(
                    "http://fanyi.baidu.com/transcontent",
                    "ie=utf-8&source=txt&query=" + raw + "&t=1327829764203&token=8a7dcbacb3ed72cad9f3fb079809a127&from=auto&to=auto",
                    function(result, json){
                        txtResult.text = json.result;
                    }
                );
            }
        }
        TextInput{id: txtResult; wrapMode: Text.WrapAnywhere; width: 300; height:300;}
    }

}

