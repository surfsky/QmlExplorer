//=============================================================================
// Copyright (c) 2014 Nicolas Froment

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//=============================================================================

import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

BusyIndicator {
    id: busy
    property int bLines: 11
    property real bLength: 10 // % of the width of the control
    property real bWidth: 5 // % of the height of the control
    property real bRadius: 13 // % of the width of the control
    property real bCorner: 1 // between 0 and 1
    property real bSpeed: 100 // smaller is faster
    property real bTrail: 0.6 // between 0 and 1
    property bool bClockWise: true

    property real bOpacity: 0.7
    property string bColor: "#7B756B"
    property string bHighlightColor: "white"
    property string bBgColor: "black"

    style: CustomBusyIndicatorStyle {
        lines: control.bLines
        length: control.bLength
        width: control.bWidth
        radius: control.bRadius
        corner: control.bCorner
        speed: control.bSpeed
        trail: control.bTrail
        clockWise: control.bClockWise
        opacity: control.bOpacity
        color: control.bColor
        highlightColor: control.bHighlightColor
        bgColor: control.bBgColor
    }
}
