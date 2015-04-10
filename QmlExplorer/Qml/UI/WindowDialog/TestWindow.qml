import QtQuick 2.0
import QtQuick.Dialogs 1.1
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0

/**
测试 Window 组件
    - import QtQuick.Window 2.0
    - 实现了 QQuickWindow
    - 是一个独立的窗口，内容完全定制
    - 属性
       modality       : 模态和非模态
       title          : 标题
       contenItem     : 自定义内容控件
       flags          :
       opacity        :
       x/y            :
       visible        : 是否可见（默认false）
       visiblility    : Qt.WindowFullScreen...
    - 事件
       closing()
    - 方法
       alert(500)          : 在状态栏闪烁?
       requestActivate()   : ?

- 在移动平台表现（待测试）
    无边框的矩形区域？
    拖动需要mousearea配合
*/
Column {
    id: root
    width: 640
    height: 480
    spacing: 10


    //--------------------------------------
    // content
    //--------------------------------------
    Row{
        width: parent.width
        spacing: 10
        Button { text: "About..." ;  onClicked: winAbout.visible=!winAbout.visible; }
        Button { text: "Image..." ; onClicked: winImage.visible=!winImage.visible;}
        Button { text: "Alert" ; onClicked: winAbout.alert(500);}
    }

    AboutWindow{id: winAbout; x:10; y:10}
    ImageWindow{id: winImage; imageUrl: 'folder.png'}
}
