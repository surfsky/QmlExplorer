/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt Quick Controls module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.3
import QtQuick.Controls 1.2


/**
stackview测试示例
    顶部标题栏，含返回按钮
    首先显示一个listview(initialItem)
        点击listview某项后跳到详情页面(push)
        listview当前行变色(hightlight)
    从详情窗口返回跳回listview窗口(pop)

stackview 简介
    内部维护了一组视图（都保存在内存中）
    增视图：push，创建新视图，并覆盖旧视图
    减视图：pop，最新的视图将退场，并释放
    自带动画效果（自定义动画请看TestStackView_Transition.qml示例）
*/
ApplicationWindow {
    visible: true
    width: 800
    height: 1280

    // 背景色
    Rectangle {
        color: "white"
        anchors.fill: parent
    }

    // 顶部工具栏
    toolBar: BorderImage {
        border.bottom: 8
        source: "images/toolbar.png"
        width: parent.width
        height: 100

        // 返回按钮
        Rectangle {
            id: backButton
            width: opacity ? 60 : 0
            anchors.left: parent.left
            anchors.leftMargin: 20
            opacity: stackView.depth > 1 ? 1 : 0
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            height: 60
            radius: 4
            color: backmouse.pressed ? "lightblue" : "transparent"
            Behavior on opacity { NumberAnimation{} }
            Text {
                text: "<"
                color: 'white'
                font.bold: true
                font.pixelSize: 40
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            MouseArea {
                id: backmouse
                anchors.fill: parent
                anchors.margins: -10
                onClicked: {stackView.pop(); lblTitle.text="Page Gallery";}
            }
        }

        // 标题
        Text {
            id: lblTitle
            font.pixelSize: 42
            x: backButton.x + backButton.width + 20
            anchors.verticalCenter: parent.verticalCenter
            color: 'white'
            text: "Page Gallery"
            font.bold: true
            Behavior on x { NumberAnimation{ easing.type: Easing.OutCubic} }
        }
    }



    // 堆栈视图
    // 项目点击时请加上 if (!statckView.busy) 判断，否则快速点击会打开两个同样的窗口
    StackView {
        id: stackView
        anchors.fill: parent
        focus: true
        Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1) {
                             stackView.pop();
                             event.accepted = true;
                         }
        initialItem: Rectangle {
            width: parent.width
            height: parent.height
            color: 'white'


            ListView {
                id: lv
                anchors.fill: parent
                model: ListModel {
                    id: listModel
                    ListElement {title: "Page1"; page: "../Page1.qml"}
                    ListElement {title: "Page2"; page: "../Page2.qml"}
                    ListElement {title: "Page3"; page: "../Page3.qml"}
                }
                delegate: Item{
                    id: listItem
                    width: parent.width
                    height: 40
                    Text{
                        text: title;
                        font.pixelSize: 20;
                        anchors.verticalCenter: parent.verticalCenter;
                        x:10
                    }
                    MouseArea{
                        anchors.fill: parent;
                        //onPressed: parent.color = 'lightblue'
                        //onReleased: parent.color = 'transparent'
                        onClicked: {
                            if (!stackView.busy) {
                                stackView.push(Qt.resolvedUrl(page))  ////
                                lblTitle.text = title;
                            }
                            lv.currentIndex = index;
                        }
                    }
                    Rectangle{
                        width: parent.width
                        height: 1
                        y: parent.height -1
                        color: '#f0f0f0'
                    }
                }

                // 想让当前选择行变色（老的不会消失？）
                highlight: Rectangle{
                    width: parent.width
                    height: 40
                    color: 'lightblue'
                }
            }
        }
    }
}
