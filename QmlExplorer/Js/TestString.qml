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
        text: '字符串操作测试，请查看控制台输出'
    }

    Button {
        text: 'go'
        onClicked:{
            console.log("hello {0} everyone".format('world'));
            console.log('*'.repeat(8));
            console.log('Hello World'.contains('Wor'));
            console.log('Hello World'.count('o'));
            console.log('hello world'.capitalize());
            console.log(' Hello World'.trim('Wor'));
            console.log('Hello World'.clear('Wor'));
            console.log('Hello World'.startsWith('Hel'));
            console.log('Hello World'.endsWith('Wor'));
            console.log('Hello World'.insert('Wor', 8));

            // C语言风格字符串格式化
            Common.log('%06d', 10);
            Common.log('% 6d', 10);
            Common.log('% 6s', 'he');
            Common.log('%06f', 10.3);
            Common.log('%06.3f', 10.3);
        }
    }
}
