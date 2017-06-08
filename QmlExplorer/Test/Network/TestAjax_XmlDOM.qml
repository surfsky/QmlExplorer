import QtQuick 2.0
import QtQuick.Controls 1.2


/**
读取本地xml文件示例
*/
Column {
    width: 350; height: 400
    spacing: 10

    function log(text) {
        txtLog.text = txtLog.text + "\n" + text
        console.log(text)
    }

    Button {
        id: button
        text: "Request data.xml"
        onClicked: {
            txtLog.text = ""
            var doc = new XMLHttpRequest();
            doc.onreadystatechange = function() {
                if (doc.readyState == XMLHttpRequest.HEADERS_RECEIVED) {
                    // 分析HEAD
                    log("[Headers]\r\n" + doc.getAllResponseHeaders ());
                    log("\r\n[Last modified]\r\n"+ doc.getResponseHeader ("Last-Modified"));
                } else if (doc.readyState == XMLHttpRequest.DONE) {
                    // 分析XML
                    log("\r\n[Content]\r\n" + doc.responseText);
                    log("\r\n[XML DOM]:");
                    var a = doc.responseXML.documentElement;
                    for (var i = 0; i < a.childNodes.length; ++i) {
                        log(a.childNodes[i].nodeName);
                    }
                }
            }

            doc.open("GET", "data.xml");
            doc.send();
        }
    }

    Text { id: txtLog;}
}

