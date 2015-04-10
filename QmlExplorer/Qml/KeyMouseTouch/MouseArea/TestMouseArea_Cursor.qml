import QtQuick 2.0

/**
测试系统光标
*/
Rectangle {
    width: 500
    height: 500

    ListModel{
        id: model
        ListElement{cursor:Qt.ArrowCursor       }
        ListElement{cursor:Qt.UpArrowCursor     }
        ListElement{cursor:Qt.CrossCursor       }
        ListElement{cursor:Qt.WaitCursor        }
        ListElement{cursor:Qt.IBeamCursor       }
        ListElement{cursor:Qt.SizeVerCursor     }
        ListElement{cursor:Qt.SizeHorCursor     }
        ListElement{cursor:Qt.SizeBDiagCursor   }
        ListElement{cursor:Qt.SizeFDiagCursor   }
        ListElement{cursor:Qt.SizeAllCursor     }
        ListElement{cursor:Qt.BlankCursor       }
        ListElement{cursor:Qt.SplitVCursor      }
        ListElement{cursor:Qt.SplitHCursor      }
        ListElement{cursor:Qt.PointingHandCursor}
        ListElement{cursor:Qt.ForbiddenCursor   }
        ListElement{cursor:Qt.WhatsThisCursor   }
        ListElement{cursor:Qt.BusyCursor        }
        ListElement{cursor:Qt.OpenHandCursor    }
        ListElement{cursor:Qt.ClosedHandCursor  }
        ListElement{cursor:Qt.DragCopyCursor    }
        ListElement{cursor:Qt.DragMoveCursor    }
        ListElement{cursor:Qt.DragLinkCursor    }
    }

    GridView{
        anchors.fill: parent;
        cellWidth: 105; cellHeight: 55
        model: model
        delegate: Rectangle{
            id: rect
            width: 100
            height: 50
            color: 'lightblue'
            Text{ text: cursor; anchors.centerIn: parent}
            MouseArea {
                id: area
                anchors.fill: parent
                cursorShape: cursor
                acceptedButtons: Qt.NoButton
            }
        }
    }




}
