import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1


/*
默认样式库。请继承并实现。
*/
Item {
    // 属性
    property color colorBg : 'white';
    property color colorText : 'black';

    /*
    // 这段代码失败，编译不通过：Font无法创建,Element is not creatable.
    property var  fontNormal : Font{
        pixelSize: 12
        bold: false
        italic: false
        family: '微软雅黑'
    }
    property var  fontBig : Font{
        pixelSize: 16
        bold: true
        italic: false
        family: '微软雅黑'
    }
    property var  fontSmall : Font{
        pixelSize: 10
        bold: false
        italic: false
        family: '微软雅黑'
    }
    */
    // 以下是折衷方法。还是比较麻烦的，希望以后版本的qml开放Font的创建功能
    property var  fontNormal : QtObject{
        property var pixelSize: 12;
        property var bold: false;
        property var italic: false;
        property var family: '微软雅黑'
    }


    // 控件样式
    property Component busyIndicatorStyle : BusyIndicatorStyle {}
    property Component buttonStyle        : ButtonStyle        {}
    property Component checkBoxStyle      : CheckBoxStyle      {}
    property Component comboBoxStyle      : ComboBoxStyle      {}
    property Component progressBarStyle   : ProgressBarStyle   {}
    property Component radioButtonStyle   : RadioButtonStyle   {}
    property Component sliderStyle        : SliderStyle        {}
    property Component spinBoxStyle       : SpinBoxStyle       {}
    property Component statusBarStyle     : StatusBarStyle     {}
    property Component switchStyle        : SwitchStyle        {}
    property Component textAreaStyle      : TextAreaStyle      {}
    property Component textFieldStyle     : TextFieldStyle     {}
    property Component toolBarStyle       : ToolBarStyle       {}
    property Component scrollViewStyle    : ScrollViewStyle    {}
    property Component tabViewStyle       : TabViewStyle       {}
    property Component tableViewStyle     : TableViewStyle     {}
}
