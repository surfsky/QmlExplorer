/**
资源类（可放图片、样式等全局变量。单例模式）
    使用：
        import "."
        Screen.onPixelDensityChanged: {R.init(Screen.pixelDensity);}
        var c = Res.logo;
    参照单例模式，可创建类似的全局类：
        Global.qml
        Styles.qml
        Res.qml
    或直接集中在一个文件里面，用类似分组属性的方式来访问（可惜没智能提示）

设备显示密度相关
    参考 http://www.kdab.com/pixels-trust-scalable-uis-qml-part-2/
    概念和公式
        ppmm(每毫米多少像素) = Screen.pixelDensity
        ppi(每英寸多少像素)  = ppmm * 25.4 像素
        point(点,磅)       = 1/72 英寸 = 25.4/72 毫米 = 25.4/72 * dp 像素
        ppp（每个点多少像素）= 25.4/72 * ppmm 像素
        5mm               = 5*ppmm 像素
    要想在不同的设备上显示同样大小
        以 pointSize 作为参照：文字可用 pointSize（点）；其它可参照折算为像素： pointSize*ppp
        以 pixelSize 作为参照：文字可用 20*ppmm（毫米）；其它可直接用 pixel

Screen对象
    初始化时机
        不会在Component.onCompleted时初始化，必须在Screen.onPixelDensityChanged初始化
        我现在怀疑Screen对象只依附于qml文件，别的文件调用了本文件，Screen仍然只认容器qml
    依赖ppi的属性设置方案
        /属性（fail）
            readonly property double dpi: Screen.pixelDensity * 25.4;
        /方法（fail）
           readonly property string resDir: getResDir();
        /ppmm由调用窗口输入（ok）
        JS绑定表达式
        属性改为方法
        纯json文件
*/

pragma Singleton
import QtQuick 2.0
import QtQuick.Window 2.0

Item {
    // ppmm的值必须由使用窗口填充
    property double ppmm : Screen.pixelDensity;  // 每毫米多少像素(pixel per mm)
    property double ppi : ppmm*25.4;             // 每英寸多少像素(pixel per inch)
    property double ppp : ppi/72;                // 每点多少像素(pixel per point)不准确，换成64差不多

    // 使用R的资源前，请先初始化
    function init(pixelDensity){ppmm = pixelDensity;}


    //----------------------------------------------
    // 获取像素密度相关的资源路径
    //----------------------------------------------
    function getRes(name){
        return getResDir() + name;
    }
    function getResDir()
    {
        if (ppi >= 480)      return "res/xxhdpi/";
        else if (ppi >= 320) return "res/xhdpi/";
        else if (ppi >= 240) return "res/hdpi/";
        else if (ppi >= 180) return "res/mdpi/";
        else                 return "res/ldpi/";
    }



    //----------------------------------------------
    // 图片资源
    //----------------------------------------------
    property var img : QtObject{
        property string logo : getRes('logo.png');
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
        property double buttonWidth: 30*ppmm;   // 30mm
        property double buttonHeight: 9*ppmm;   // 30mm
    }
}
