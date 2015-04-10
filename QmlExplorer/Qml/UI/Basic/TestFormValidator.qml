import QtQuick 2.0
import QtQuick.Controls 1.1

Column {
    x:20
    y:20
    width: 640
    height: 480
    spacing: 10


    // 验证器
    IntValidator    {id: intVal; bottom:10; top:100; }
    DoubleValidator {id: doubleVal; decimals:4; bottom:10; top:100; notation:DoubleValidator.StandardNotation}
    RegExpValidator {id: regexVal;    regExp:/^[a-zA-Z]{1}{0,2}[a-z]{1,3}$/;}
    RegExpValidator {id: passwordVal; regExp:/[a-zA-Z0-9]{6,20}/;}



    // 文本框（使用验证器）
    Label{text: 'int'}
    TextInput{
        text: ''
        validator: intVal
        width:  100; height: 40
        color: 'red'
        focus: true
        BorderImage {
            id: name
            width:95; height:25
            source: "../../images/textfield.png"
            border.left: 5; border.top: 5
            border.right: 5; border.bottom: 5
        }
    }

    Label{text: 'double'}
    TextInput{
        text: ''
        validator: doubleVal
        width:  100; height: 40
    }

    Label{text: 'regex'}
    TextInput{
        text: ''
        validator: regexVal
        width:  100; height: 40
    }

    Label{text: 'int'}
    TextInput{
        validator: IntValidator{bottom: 11; top: 31;}
        width:  100; height: 40
    }

    Label{text: 'password'}
    TextInput{
        text: 'password'
        echoMode: TextInput.Password
        validator: passwordVal
        width:  100; height: 40
    }


}
