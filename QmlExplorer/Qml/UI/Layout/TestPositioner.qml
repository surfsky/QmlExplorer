import QtQuick 2.0
import "../../Controls/"


/**
测试定位器（Row/Column/Grid/Flow)
注意：
- 使用这些定位器需要显式的指定内部元素的高度和宽度，否则会重叠
*/
Column {
    width: 640
    height: 640
    spacing: 10


    Text{ text: 'row'}
    Row{
        spacing: 10
        Square {text:'1'}
        Square {text:'2'}
        Square {text:'3'}
        Square {text:'4'}
        Square {text:'5'}
    }

    Text{ text: 'column'}
    Column{
        spacing: 10
        Square {text:'1'}
        Square {text:'2'}
        Square {text:'3'}
    }

    Text{ text: 'grid'}
    Grid{
        columns: 3
        spacing: 10
        Square {text:'1'}
        Square {text:'2'}
        Square {text:'3'}
        Square {text:'4'}
        Square {text:'5'}
    }

    Text{ text: 'flow'}
    Flow{
        spacing: 10
        anchors.left: parent.left
        anchors.right: parent.right
        Square {text:'1'}
        Square {text:'2'}
        Square {text:'3'}
        Square {text:'4'}
        Square {text:'5'}
    }
}
