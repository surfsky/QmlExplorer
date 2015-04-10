import QtQuick 2.0


/**
ios 7/8键盘模拟
    /外观模拟
    /输出普通字符
    /退格键、回车键等特殊处理
    /出入场动画
    /back键隐藏
    /在光标处增减字符
*/
Rectangle {
    id: root
    width: 800
    height: 160
    color: '#e0e0e0'
    anchors.margins: 5

    //----------------------------------
    // 公共属性和信号
    //----------------------------------
    // 关联的TextInput/TextEdit/TextArea控件（有text和cursorPosition属性）
    property Item textbox;

    // 显示哪个面板
    function showPanel(panel)
    {
        panelChar.visible = false;
        panelCharCaps.visible = false;
        panelDigit.visible = false;
        panelSymbol.visible = false;
        if (panel == 'char')      panelChar.visible = true;
        if (panel == 'charCaps')  panelCharCaps.visible = true;
        if (panel == 'digit')     panelDigit.visible = true;
        if (panel == 'symbol')    panelSymbol.visible = true;
    }

    // 处理输入的字符
    function inputChar(c){
        var n = root.textbox.cursorPosition;
        if (c == '\b')
            root.textbox.remove(n-1, n);
        else
            root.textbox.insert(n, c);
    }

    //----------------------------------
    // 出入场动画
    //----------------------------------
    function show(textbox){
        root.textbox = textbox;
        if (!root.visible){
            init();
            root.visible = true;
            animShow.start();
        }
    }
    function hide(){
        if (root.visible){
            animHide.start();
        }
    }

    function init()
    {
        var top = getRoot(root);
        root.parent = top;
    }

    function getRoot(item)
    {
        return (item.parent !== null) ? getRoot(item.parent) : item;
    }

    PropertyAnimation{
        id: animShow
        target: root
        properties: 'y'
        from: root.parent.height
        to: root.parent.height - root.height
        easing.type: Easing.OutExpo
        duration: 300
    }
    PropertyAnimation{
        id: animHide
        target: root
        properties: 'y'
        from: root.parent.height - root.height
        to: root.parent.height
        easing.type: Easing.OutExpo
        duration: 300
        onStopped: root.visible=false;
    }

    Keys.onBackPressed: if (root.visible) root.hide();


    //----------------------------------
    // 字符按钮面板
    //----------------------------------
    Item{
        id: panelChar
        anchors.fill: parent
        anchors.topMargin: 5
        Column{
            anchors.fill: parent
            spacing: 10

            // qwertyuiop
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: 30
                spacing: 3
                Key{text:'q'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'w'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'e'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'r'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'t'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'y'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'u'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'i'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'o'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'p'; width:root.width/10-3; onInputed: root.inputChar(c);}
            }
            // asdfghjkl
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: 30
                spacing: 3
                Key{text:'a'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'s'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'d'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'f'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'g'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'h'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'j'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'k'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'l'; width:root.width/10-3; onInputed: root.inputChar(c);}
            }
            // zxcvbnm
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: 30
                spacing: 3
                KeySpecial{text:'caps'; width:root.width/10-3; onInputed: root.showPanel('charCaps')}
                Rectangle{height:30; color:'transparent'; width:root.width/20-2}
                Key{text:'z'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'x'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'c'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'v'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'b'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'n'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'m'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Rectangle{height:30; color:'transparent'; width:root.width/20-5}
                KeySpecial{text:'del'; width:root.width/10-3; onInputed: root.inputChar('\b');}
            }
            // 123/space/return
            Row{
                width: root.width
                height: 30
                spacing: 3
                KeySpecial{text:'123'; width:root.width/10-3;  onInputed: root.showPanel('digit')}
                Key{text:'space'; width: root.width*0.7 - 3; onInputed: root.inputChar(' ');}
                KeySpecial{text:'hide'; width:root.width/10-3; onInputed: root.hide()}
                KeySpecial{text:'return'; width:root.width/10-3; onInputed: root.inputChar('\r\n');}
            }
        }
    }

    //----------------------------------
    // 大写字符按钮面板
    //----------------------------------
    Item{
        id: panelCharCaps
        visible: false;
        anchors.fill: parent
        anchors.topMargin: 5
        Column{
            anchors.fill: parent
            spacing: 10

            // qwertyuiop
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: 30
                spacing: 3
                Key{text:'Q'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'W'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'E'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'R'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'T'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'Y'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'U'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'I'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'O'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'P'; width:root.width/10-3; onInputed: root.inputChar(c);}
            }
            // asdfghjkl
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: 30
                spacing: 3
                Key{text:'A'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'S'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'D'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'F'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'G'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'H'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'J'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'K'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'L'; width:root.width/10-3; onInputed: root.inputChar(c);}
            }
            // zxcvbnm
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: 30
                spacing: 3
                KeySpecial{text:'low'; width:root.width/10-3; onInputed: root.showPanel('char')}
                Rectangle{height:30; color:'transparent'; width:root.width/20-2}
                Key{text:'Z'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'X'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'C'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'V'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'B'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'N'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'M'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Rectangle{height:30; color:'transparent'; width:root.width/20-5}
                KeySpecial{text:'del'; width:root.width/10-3; onInputed: root.inputChar('\b');}
            }
            // 123/space/return
            Row{
                width: root.width
                height: 30
                spacing: 3
                KeySpecial{text:'123'; width:root.width/10-3; onInputed: root.showPanel('digit')}
                Key{text:'space'; width: root.width*0.7 - 3; onInputed: root.inputChar(' ');}
                KeySpecial{text:'hide'; width:root.width/10-3; onInputed: root.hide()}
                KeySpecial{text:'return'; width:root.width/10-3; onInputed: root.inputChar('\r\n');}
            }
        }
    }


    //----------------------------------
    // 数字按钮面板
    //----------------------------------
    Item{
        id: panelDigit
        visible: false;
        anchors.fill: parent
        anchors.topMargin: 5
        Column{
            anchors.fill: parent
            spacing: 10

            // qwertyuiop
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: 30
                spacing: 3
                Key{text:'1'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'2'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'3'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'4'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'5'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'6'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'7'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'8'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'9'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'0'; width:root.width/10-3; onInputed: root.inputChar(c);}
            }
            // asdfghjkl
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: 30
                spacing: 3
                Key{text:'-'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'/'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:':'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:';'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'('; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:')'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'$'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'&'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'@'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'"'; width:root.width/10-3; onInputed: root.inputChar(c);}
            }
            // zxcvbnm
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: 30
                spacing: 3
                KeySpecial{text:'#+='; width:root.width/10-3; onInputed: root.showPanel('symbol')}
                Rectangle{height:30; color:'transparent'; width:root.width/10-3}
                Key{text:'.'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:','; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'?'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'!'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:"'"; width:root.width/10-3; onInputed: root.inputChar(c);}
                Rectangle{height:30; color:'transparent'; width:root.width/10-3}
                KeySpecial{text:'del'; width:root.width/10-3; onInputed: root.inputChar('\b');}
            }
            // 123/space/return
            Row{
                width: root.width
                height: 30
                spacing: 3
                KeySpecial{text:'ABC'; width:root.width/10-3; onInputed: root.showPanel('char')}
                Key{text:'space'; width: root.width*0.7 - 3; onInputed: root.inputChar(' ');}
                KeySpecial{text:'hide'; width:root.width/10-3; onInputed: root.hide()}
                KeySpecial{text:'return'; width:root.width/10-3; onInputed: root.inputChar('\r\n');}
            }
        }
    }

    //----------------------------------
    // 字符按钮面板
    //----------------------------------
    Item{
        id: panelSymbol
        visible: false;
        anchors.fill: parent
        anchors.topMargin: 5
        Column{
            anchors.fill: parent
            spacing: 10

            // qwertyuiop
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: 30
                spacing: 3
                Key{text:'['; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:']'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'{'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'}'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'#'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'%'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'^'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'*'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'+'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'='; width:root.width/10-3; onInputed: root.inputChar(c);}
            }
            // asdfghjkl
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: 30
                spacing: 3
                Key{text:'_'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'\\'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'|'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'~'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'<'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'>'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'€'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'￡'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'￥'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'·'; width:root.width/10-3; onInputed: root.inputChar(c);}
            }
            // zxcvbnm
            Row{
                anchors.horizontalCenter: parent.horizontalCenter
                height: 30
                spacing: 3
                KeySpecial{text:'123'; width:root.width/10-3; onInputed: root.showPanel('digit')}
                Rectangle{height:30; color:'transparent'; width:root.width/10-3}
                Key{text:'.'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:','; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'?'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:'!'; width:root.width/10-3; onInputed: root.inputChar(c);}
                Key{text:"'"; width:root.width/10-3; onInputed: root.inputChar(c);}
                Rectangle{height:30; color:'transparent'; width:root.width/10-3}
                KeySpecial{text:'del'; width:root.width/10-3; onInputed: root.inputChar('\b');}
            }
            // 123/space/return
            Row{
                width: root.width
                height: 30
                spacing: 3
                KeySpecial{text:'ABC'; width:root.width/10-3; onInputed: root.showPanel('char')}
                Key{text:'space'; width: root.width*0.7 - 3; onInputed: root.inputChar(' ');}
                KeySpecial{text:'hide'; width:root.width/10-3; onInputed: root.hide()}
                KeySpecial{text:'return'; width:root.width/10-3; onInputed: root.inputChar('\r\n');}
            }
        }
    }

}

