/****************************************************************************************
**
** Copyright (C) 2013 Jolla Ltd.
** Contact: Andrew den Exter <andrew.den.exter@jollamobile.com>
** All rights reserved.
**
** This file is part of Sailfish Silica UI component package.
**
** You may use this file under the terms of BSD license as follows:
**
** Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are met:
**     * Redistributions of source code must retain the above copyright
**       notice, this list of conditions and the following disclaimer.
**     * Redistributions in binary form must reproduce the above copyright
**       notice, this list of conditions and the following disclaimer in the
**       documentation and/or other materials provided with the distribution.
**     * Neither the name of the Jolla Ltd nor the
**       names of its contributors may be used to endorse or promote products
**       derived from this software without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
** ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
** DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
** ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
** ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
** SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
****************************************************************************************/

import QtQuick 2.1

QtObject {
    // 公共属性方法
    property Flickable flickable
    function scrollToTop() {
        if (flickable.contentY > 2 * fadeDistance) {
            fadeOut.to = flickable.contentY - fadeDistance
            longReturnAnimation.start()
        } else {
            shortReturnAnimation.start()
        }
    }

    // 私有属性
    property alias fadeDistance: fadeIn.from
    property bool animating: shortReturnAnimation.running || longReturnAnimation.running
    property SequentialAnimation shortReturnAnimation: SequentialAnimation {
        id:  shortReturnAnimation
        SmoothedAnimation {
            target: flickable
            property: "contentY";
            to: flickable.originY;
            velocity: 4000
            maximumEasingTime: 100
            easing.type: Easing.InOutExpo
        }
        ScriptAction {
            script: {
                if(typeof(flickable.positionViewAtBeginning)=="function"){
                    flickable.positionViewAtBeginning();
                    flickable.originY = flickable.contentY;
                }
            }
        }
    }

    property ParallelAnimation longReturnAnimation: ParallelAnimation {
        id: longReturnAnimation

        SequentialAnimation {
            PauseAnimation { duration: 100 }
            NumberAnimation {
                target: flickable
                property: "opacity"
                duration: 400
                to: 0.0
                easing.type: Easing.InQuad
            }
            PauseAnimation { duration: 100 }
            NumberAnimation {
                target: flickable
                property: "opacity"
                duration: 400
                to: 1.0
                easing.type: Easing.OutQuad
            }
        }
        SequentialAnimation {
            NumberAnimation {
                id: fadeOut
                target: flickable
                property: "contentY"
                duration: 500
                easing.type: Easing.InExpo
            }
            NumberAnimation {
                id: fadeIn

                target: flickable
                property: "contentY"

                to: flickable.originY;
                from: 500
                duration: 500
                easing.type: Easing.OutExpo
            }
            ScriptAction {
                script: {
                    if(typeof(flickable.positionViewAtBeginning)=="function"){
                        flickable.positionViewAtBeginning();
                        flickable.originY = flickable.contentY;
                    }
                }
            }
        }
    }
}
