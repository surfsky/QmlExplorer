import QtQuick 2.0

/**
测试系统主题调色板
*/
Rectangle {
    width: 640
    height: 480


    SystemPalette {id: syspal}

    Grid{
        columns: 2
        spacing: 10

        Text{text:'base'}
        Rectangle{width:50; height:30; border.color: 'gray'; color:syspal.base}
        Text{text:'alternateBase'}
        Rectangle{width:50; height:30; border.color: 'gray'; color:syspal.alternateBase}
        Text{text:'text'}
        Rectangle{width:50; height:30; border.color: 'gray'; color:syspal.text}
        Text{text:'window'}
        Rectangle{width:50; height:30; border.color: 'gray'; color:syspal.window}
        Text{text:'windowText'}
        Rectangle{width:50; height:30; border.color: 'gray'; color:syspal.windowText}
        Text{text:'button'}
        Rectangle{width:50; height:30; border.color: 'gray'; color:syspal.button}
        Text{text:'buttonText'}
        Rectangle{width:50; height:30; border.color: 'gray'; color:syspal.buttonText}
        Text{text:'dark'}
        Rectangle{width:50; height:30; border.color: 'gray'; color:syspal.dark}
        Text{text:'mid'}
        Rectangle{width:50; height:30; border.color: 'gray'; color:syspal.mid}
        Text{text:'midlight'}
        Rectangle{width:50; height:30; border.color: 'gray'; color:syspal.midlight}
        Text{text:'light'}
        Rectangle{width:50; height:30; border.color: 'gray'; color:syspal.light}
        Text{text:'highlight'}
        Rectangle{width:50; height:30; border.color: 'gray'; color:syspal.highlight}
        Text{text:'highlightedText'}
        Rectangle{width:50; height:30; border.color: 'gray'; color:syspal.highlightedText}
        Text{text:'shadow'}
        Rectangle{width:50; height:30; border.color: 'gray'; color:syspal.shadow}
        Text{text:'colorGroup'}
        Rectangle{width:50; height:30; border.color: 'gray'; color:syspal.colorGroup}
    }
}
