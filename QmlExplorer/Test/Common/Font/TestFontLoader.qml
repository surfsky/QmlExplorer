import QtQuick 2.0


/**
fontloader组件测试
可加载系统、本地、网络上的字体
*/
Column {
    width: 600
    height: 320
    spacing: 10
    property string myText: "The quick brown fox jumps over the lazy dog."


    //------------------------------------------------
    // local font
    //------------------------------------------------
    FontLoader {
        id: localFont;
        source: "../../../Fonts/ubuntumono.ttf"
    }
    Text {
        id: txt2
        text: myText
        color: "lightsteelblue"
        width: parent.width
        wrapMode: Text.WordWrap
        font.family: localFont.name
        font.pixelSize: 20
    }

    //------------------------------------------------
    // web font 2
    //------------------------------------------------
    FontLoader {
        id: webFont2;
        source: "http://www.princexml.com/fonts/steffmann/Starburst.ttf"
    }
    Text {
        text: {
            if (webFont2.status == FontLoader.Ready) myText
            else if (webFont2.status == FontLoader.Loading) "Loading web font..."
            else if (webFont2.status == FontLoader.Error) "Error loading font"
        }
        color: "lightsteelblue"
        width: parent.width
        wrapMode: Text.WordWrap
        font.family: webFont.name;
        font.pixelSize: 20
    }


    //------------------------------------------------
    // web font 3
    //------------------------------------------------
    FontLoader {
        id: webFont3;
        source: "http://www.princexml.com/fonts/steffmann/AlbertText-Bold.ttf"
        onStatusChanged: {
            if (webFont3.status == FontLoader.Ready)        txt1.text = myText;
            else if (webFont3.status == FontLoader.Loading) txt1.text = "Loading web font...";
            else if (webFont3.status == FontLoader.Error)   txt1.text = "Error loading font";
        }
    }
    Text {
        id: txt1
        text: myText;
        color: "lightsteelblue"
        width: parent.width
        wrapMode: Text.WordWrap
        font.family: webFont3.name;
        font.pixelSize: 20
    }


}
