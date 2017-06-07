import QtQuick 2.2
import QtQuick.Controls 1.1
import "../controls/"

Column{
    id: rectangle1
    width: 480
    height: 640
    spacing: 10

    // 描述色彩的一些语法
    Grid{
        x:5
        y:5
        columns: 4
        spacing: 5
        Cell{
            width:100
            color:'steelblue'
            text:'steelblue'
        }
        Cell{
            width:100
            color:Qt.lighter("steelblue")
            text:"Qt.lighter()"
        }
        Cell{
            width:100
            color:Qt.darker("steelblue")
            text:'Qt.darker()'
        }
        Cell{
            width:100
            color:Qt.tint("lightsteelblue", "#10FF0000")
            text:"Qt.tint()"
        }
        Cell{
            width:100
            color:"transparent"
            text:"transparent"
        }
        Cell{
            width:100
            color:"#990000FF"    // 格式为：#AARRGGBB，别弄反了
            text:"#990000FF"
        }
        Cell{
            width:100
            color:Qt.rgba(1, 0, 0, 1)
            text:"Qt.rgba()"
        }
        Cell{
            width:100
            color:Qt.hsla(0.5, 1.0, 0.5, 1)
            text:"Qt.hsla()"
        }
    }

    // 绘制一个调色板
    Flow{
        spacing: 2
        width: 8*(30+2)
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(1.0/8*index, 1.0/8*index, 1.0/8*index, 1)
            }
        }
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(1.0/8*index, 0, 0, 1)
            }
        }
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(0, 1.0/8*index, 0, 1)
            }
        }
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(0, 0, 1.0/8*index, 1)
            }
        }

        //
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(1.0/8*index, 1, 1, 1)
            }
        }
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(1, 1.0/8*index, 1, 1)
            }
        }
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(1, 1, 1.0/8*index, 1)
            }
        }


        //
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(1.0/8*index, 1, 0, 1)
            }
        }
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(1.0/8*index, 0, 1, 1)
            }
        }
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(1, 1.0/8*index, 0, 1)
            }
        }
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(0, 1.0/8*index, 1, 1)
            }
        }
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(1, 0, 1.0/8*index, 1)
            }
        }
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(0, 1, 1.0/8*index, 1)
            }
        }

        //
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(1.0/8*index, 1, 0.5, 1)
            }
        }
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(1.0/8*index, 0.5, 1, 1)
            }
        }
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(1, 1.0/8*index, 0.5, 1)
            }
        }
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(0.5, 1.0/8*index, 1, 1)
            }
        }
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(1, 0.5, 1.0/8*index, 1)
            }
        }
        Repeater{
            model: 8
            delegate: Rectangle{
                width: 30; height: 30
                color: Qt.rgba(0.5, 1, 1.0/8*index, 1)
            }
        }
    }

}

