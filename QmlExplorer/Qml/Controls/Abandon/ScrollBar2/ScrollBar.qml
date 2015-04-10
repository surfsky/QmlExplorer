/*
	ScrollBar component for QML Flickable

	Copyright (c) 2010 Gregory Schlomoff - gregory.schlomoff@gmail.com

	This code is released under the MIT license

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
*/



import QtQuick 2.3
import QtQuick.Controls 1.2


/*
滚动轴组件，虽然很丑，可用
可用ScrollView替代，设置style即可
Usage:
    Flickable {
      id: myFlickable
      ...
    }
    ScrollBar {
      target: myFlickable
    }
*/
BorderImage {
	property variant target

	source: "images/scrollbar.png"
	border {left: 0; top: 3; right: 0; bottom: 3}
    width: 17

	anchors {top: target.top; bottom: target.bottom; right: target.right }
	visible: (track.height == slider.height) ? false : true //TODO: !visible -> width: 0 (but creates a binding loop)

	Item {
		anchors {fill: parent; margins: 1; rightMargin: 2; bottomMargin: 2}

		Image {
			id: upArrow
			source: "images/up-arrow.png"
			anchors.top: parent.top
			MouseArea {
				anchors.fill: parent
				onPressed: {
					timer.scrollAmount = -10
					timer.running = true;
				}
				onReleased: {
					timer.running = false;
				}
			}
		}

		Timer {
			property int scrollAmount

			id: timer
			repeat: true
			interval: 20
			onTriggered: {
				target.contentY = Math.max(
						0, Math.min(
						target.contentY + scrollAmount,
						target.contentHeight - target.height));
			}
		}

		Item {
			id: track
			anchors {top: upArrow.bottom; topMargin: 1; bottom: dnArrow.top;}
			width: parent.width

			MouseArea {
				anchors.fill: parent
				onPressed: {
					timer.scrollAmount = target.height * (mouseY < slider.y ? -1 : 1)	// scroll by a page
					timer.running = true;
				}
				onReleased: {
					timer.running = false;
				}
			}

			BorderImage {
				id:slider

				source: "images/slider.png"
				border {left: 0; top: 3; right: 0; bottom: 3}
				width: parent.width

				height: Math.min(target.height / target.contentHeight * track.height, track.height)
				y: target.visibleArea.yPosition * track.height

				MouseArea {
					anchors.fill: parent
					drag.target: parent
					drag.axis: Drag.YAxis
					drag.minimumY: 0
					drag.maximumY: track.height - height

					onPositionChanged: {
						if (pressedButtons == Qt.LeftButton) {
							target.contentY = slider.y * target.contentHeight / track.height
						}
					}
				}
			}
		}
		Image {
			id: dnArrow
			source: "images/dn-arrow.png"
			anchors.bottom: parent.bottom
			MouseArea {
				anchors.fill: parent
				onPressed: {
					timer.scrollAmount = 10
					timer.running = true;
				}
				onReleased: {
					timer.running = false;
				}
			}
		}
	}
}
