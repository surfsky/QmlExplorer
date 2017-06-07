/*
 * Copyright (c) 2013, Juergen Bocklage-Ryannel, Johan Thelin
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the editors nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import QtQuick 2.0


/**
绘图板示例（修改自Qt官方示例）
    /绘图
    /色彩选择器
    线宽选择器
    橡皮
    绘制曲线
    绘制文字
    IO:
        保存
        读取
*/
Rectangle {
    id: root
    width: 400; height: 300
    color: "#333333"

    // 全局属性
    property color _color: "#33B5E5"     // 色彩
    property int _lineWidth : 4;         // 线宽

    //---------------------------------------
    // 色彩选择面板
    //---------------------------------------
    Row {
        id: colorTools
        spacing: 4
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 8
        }
        Repeater {
            model: ["#33B5E5", "#99CC00", "#FFBB33", "#FF4444"]
            ColorSquare {
                color: modelData
                active: _color == color
                onClicked: _color = color
            }
        }
    }

    //---------------------------------------
    // 绘图区背景色
    //---------------------------------------
    Rectangle {
        anchors.fill: canvas
        border.color: "#666666"
        border.width: 4
    }

    //---------------------------------------
    // 绘图区
    //---------------------------------------
    Canvas {
        id: canvas
        anchors {
            left: parent.left
            right: parent.right
            top: colorTools.bottom
            bottom: parent.bottom
            margins: 8
        }

        property point lastPt;
        onPaint: {
            var ctx = getContext('2d');
            ctx.lineWidth = root._lineWidth;
            ctx.strokeStyle = root._color;
            ctx.beginPath();
            ctx.moveTo(lastPt.x, lastPt.y);
            lastPt = Qt.point(area.mouseX, area.mouseY);
            ctx.lineTo(lastPt.x, lastPt.y);
            ctx.stroke();
        }
        MouseArea {
            id: area
            anchors.fill: parent
            onPressed: {canvas.lastPt = Qt.point(mouseX, mouseY);}
            onPositionChanged: {canvas.requestPaint();}
        }
    }
}
