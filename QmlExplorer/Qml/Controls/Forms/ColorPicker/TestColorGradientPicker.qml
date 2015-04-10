import QtQuick 2.0
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0

/**
测试渐变取色器
*/
Column {
    width: 800
    height: 600
    spacing: 10

    RadialGradient{
        id: grdt
        width: 200; height: 200
        gradient: pkr.gradient
    }

    ColorGradientPicker{
        id: pkr
    }

    Button{
        text: 'set gradient';
        onClicked: {grdt.gradient = pkr.gradient;}
    }
}

