import QtQuick 2.0
import QtQuick.Controls 1.2
import "json.js" as Json


/**
Json.js 测试
*/
Column {
    width: 300
    height: 300
    spacing: 5


    Text{
        text: 'Json操作测试，请查看控制台输出'
    }

    Button {
        text: 'go'
        onClicked:{
            var json = {
                "FirstName": "John",
                "LastName": "Doe",
                "Age": 43,
                "Address": {
                    "Street": "Downing Street 10",
                    "City": "London",
                    "Country": "Great Britain"
                },
                "Phone numbers": [
                    "+44 1234567",
                    "+44 2345678"
                ]
            };

            var txt = Json.toStr(json);
            var obj = Json.toJson(txt);
            console.log(txt);
            console.log(Json.toStr(obj));
        }
    }
}
