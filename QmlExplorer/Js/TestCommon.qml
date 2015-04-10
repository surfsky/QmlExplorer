import QtQuick 2.0
import QtQuick.Controls 1.2
import "common.js" as Common

/**
string.js 测试
*/
Column {
    width: 300
    height: 300
    spacing: 5

    Text{
        text: 'Common 常用方法测试，请查看控制台输出'
    }

    Button {
        text: 'alert'
        onClicked:{
            Common.alert('title', '这是提示对话框', parent, function(){
                console.log('ok');
            });
        }
    }

    Button {
        text: 'question'
        onClicked:{
            Common.question('title', '这是询问对话框？', parent,
                function(){console.log('yes');},
                function(){console.log('no');}
            );
        }
    }
}
