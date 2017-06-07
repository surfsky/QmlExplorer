import QtQuick 2.0
import "common.js" as Common


/**
打印ASCII码表
*/
Column {
    width: 400
    height: 200

    Text{text: '打印ASCII码表测试，请查看控制台'}

    Component.onCompleted: {
        printAscii();
    }

    function printAscii()
    {
        Common.log("\nStd Ascii\n");
        for(var i=0;i<128;++i)
        {
            Common.log("% 3d    %c", i, String.fromCharCode(i));
        }

        // 扩展ASCII码表（打印不出来，可能需要指定编码页）
        Common.log("\nExt Ascii\n");
        for(var i=128;i<256;++i)
        {
            Common.log("% 3d    %c", i, String.fromCharCode(i));
        }
    }
}

