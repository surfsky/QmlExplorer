pragma Singleton
import QtQuick 2.0


/**
自定义的一系列动画。
已封装为单例，单例模式可参考Common/Singleton章节
调用方法：
    Animations.playAnimation(id, 'X');
*/
QtObject {
    property PropertyAnimation animX : PropertyAnimation {
        properties: "x";
        to: 200
    }
    property PropertyAnimation animY : PropertyAnimation {
        properties: "y";
        to: 200
    }

    function playAnimation(target, type){
        var anim = eval('anim' + type);
        anim.target = target;
        anim.start();
    }
}

