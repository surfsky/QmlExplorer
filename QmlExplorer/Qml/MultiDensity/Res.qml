import QtQuick 2.0
import QtQuick.Window 2.0

QtObject {
    /*
    分辨率折算
        参考 http://www.kdab.com/pixels-trust-scalable-uis-qml-part-2/
        Screen.pixelDensity: 每毫米多少个像素
        DPI: 每英寸多少个像素(1英寸=25.4毫米）=Screen.pixelDensity*25.4
    要想在不同的设备上显示同样大小
        文字可直接使用pointSize
        图片可将物理尺寸折算为像素： pointSize*Screen.pixelDensity
   ----------------------------------------------
    Screen对象不会在Component.onCompleted时初始化
    我现在怀疑Screen对象只依附于qml文件，别的文件调用了本文件，Screen仍然只认容器qml
    用属性和方法都有问题。。。
       readonly property double dpi: Screen.pixelDensity * 25.4;
       readonly property string resDir: getResDir();
    最后办法
        试试JS绑定表达式
        属性改为方法
        纯js文件
    */
    function getDpi(){
        return Screen.pixelDensity * 25.4;
    }
    function getDpmm(){
        return Screen.pixelDensity;
    }

    function getResDir()
    {
        var dpi = Screen.pixelDensity * 25.4;
        if (dpi >= 480)      return "res/xxhdpi/";
        else if (dpi >= 320) return "res/xhdpi/";
        else if (dpi >= 240) return "res/hdpi/";
        else if (dpi >= 180) return "res/mdpi/";
        else                 return "res/ldpi/";
    }

    function getRes(name){
        return getResDir() + name;
    }


    //----------------------------------------------
    // 图片资源
    //----------------------------------------------
    property var img : QtObject{
        property string logo : getRes('logo.png');
        function getLogo(){return getRes('logo.png');}
    }

    //----------------------------------------------
    // 图片资源
    //----------------------------------------------
    property var text : QtObject{
        property string solagon: 'hello world';
    }

    //----------------------------------------------
    // 样式资源
    //----------------------------------------------
    property var style : QtObject{
        property color buttonColor: 'lightgreen'
        property double buttonWidth: 30*getDpmm();
        property double buttonHeight: 9*getDpmm();
    }
}
