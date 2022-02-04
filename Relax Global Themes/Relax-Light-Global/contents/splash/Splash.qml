/*
 *   Copyright 2014 Marco Martin <mart@kde.org>
 *   Copyright 2018 Fabian Vogt <fabian@ritter-vogt.de>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.5
import QtGraphicalEffects 1.0

Image {
    id: root
    source: "images/1920x1080.png"
    fillMode: Image.PreserveAspectCrop

    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true;
        } else if (stage == 3) {
            casingIntroAnimation.running = true;
            highlightIntroAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }
    FastBlur {
        id: casingBlur
        opacity: 0
        anchors.fill: casing
        radius: 5
        source: casing
    }
    FastBlur {
        id: highlightBlur
        opacity: 0
        anchors.fill: highlight
        radius: 50
        source: highlight
    }
    Image {
        id: highlight
        opacity: 0
        source: "images/highlight.svg"
        fillMode: Image.PreserveAspectFit
        height: parent.height * 0.5
        width: parent.height * 0.5 // The image is square
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.2
        
    }
    Image {
        id: casing
        opacity: 0.05
        source: "images/plasma.svg"
        fillMode: Image.PreserveAspectFit
        height: parent.height * 0.5
        width: parent.height * 0.5 // The image is square
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.2
    }
    
    
    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Image {
            id: busyIndicator
            anchors.horizontalCenter: parent.horizontalCenter
            y: parent.height * 0.70
            source: "images/busywidget.svg"
            sourceSize.height: units.gridUnit * 6
            sourceSize.width: units.gridUnit * 6
            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 1500
                loops: Animation.Infinite
            }
        }
    }

        OpacityAnimator {
            id: introAnimation
            running: false
            target: content
            from: 0
            to: 1
            duration: 1000
            easing.type: Easing.InExpo
        }
        ColorAnimation {
            id: colorIntroAnimation
            running: true
            target: root
            property: "color"
            from: "black"
            to: "#081c2d"
            duration: 2000
            easing.type: Easing.InExpo
        }
        OpacityAnimator {
            id: casingIntroAnimation
            running: false
            target: casingBlur
            from: 0
            to: 1
            duration: 800
            easing.type: Easing.InBounce
        }
        OpacityAnimator {
            id: highlightIntroAnimation
            running: false
            target: highlightBlur
            from: 0
            to: 1
            duration: 800
            easing.type: Easing.InBounce
        }
        
}
