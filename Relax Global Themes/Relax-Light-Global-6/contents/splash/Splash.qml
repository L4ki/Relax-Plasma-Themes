/*
 *   Copyright 2014 Marco Martin <mart@kde.org>
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

import QtQuick
import org.kde.kirigami 2 as Kirigami

Image {
    id: root
    source: "images/background.png"
    fillMode: Image.PreserveAspectCrop
    
    property int stage

    onStageChanged: {
        if (stage == 2) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
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
            id: logo
            //match SDDM/lockscreen avatar positioning
            property real size: units.gridUnit * 12
            opacity: 0.9
            anchors.centerIn: parent

            source: ""

            sourceSize.width: size
            sourceSize.height: size
        }
        
        FontLoader {
         source: "../components/artwork/fonts/OpenSans-Light.ttf"
        }

        Text {
            id: date1
            text:Qt.formatDateTime(new Date(),"hh:mm A")
            font.pointSize: 32
            color: "#1e3c5a"
            opacity:1.00
            font { family: "OpenSans Bold"; weight: Font.Bold ;capitalization: Font.Capitalize}
            anchors.horizontalCenter: parent.horizontalCenter
            y: (parent.height - height) / 1.2
        }
        
        Text {
            id: date2
            text:Qt.formatDateTime(new Date(),"'The day is' dddd MMMM d yyyy")
            font.pointSize: 22
            color: "#1e3c5a"
            opacity:1.00
            font { family: "OpenSans Bold"; weight: Font.Bold ;capitalization: Font.Capitalize}
            anchors.horizontalCenter: parent.horizontalCenter
            y: (parent.height - height) / 1.1
        }

        Image {
            id: busyIndicator1
            //in the middle of the remaining space
            //y: (parent.height - height) / 1.7
            y: root.height - (root.height - logo.y) / 1.5 - height/2
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/busywidget3.svg"
            opacity: 0.9
            sourceSize.height: units.gridUnit * 2.2
            sourceSize.width: units.gridUnit * 2.2
            RotationAnimator on rotation {
                id: rotationAnimator1
                from: 360
                to: 0
                duration: 1100
                loops: Animation.Infinite
            }
        }
        
        Image {
            id: busyIndicator2
            //in the middle of the remaining space
            //y: (parent.height - height) / 1.7
            y: root.height - (root.height - logo.y) / 1.5 - height/2
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/busywidget4.svg"
            opacity: 0.9
            sourceSize.height: units.gridUnit * 2.6
            sourceSize.width: units.gridUnit * 2.6
            RotationAnimator on rotation {
                id: rotationAnimator2
                from: 0
                to: 360
                duration: 1100
                loops: Animation.Infinite
            }
        }
        
        
        Row {
            spacing: units.smallSpacing*2
            anchors {
                bottom: parent.bottom
                right: parent.right
                rightMargin: units.gridUnit * 1.5
                margins: units.gridUnit
            }
            Image {
                source: "images/Plasma.png"
                sourceSize.height: units.gridUnit * 8
                sourceSize.width: units.gridUnit * 8
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 400
        easing.type: Easing.InOutQuad
    }
}
