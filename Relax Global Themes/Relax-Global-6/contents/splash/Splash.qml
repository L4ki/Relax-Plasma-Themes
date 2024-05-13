import QtQuick 2.5


Image {
    id: root
    source: "images/Neonyt-Wallpaper-No Plasma-Logo.jpg"

    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true
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
            property real size: units.gridUnit * 10

            anchors.centerIn: parent

            source: "images/plasma.svg"

            sourceSize.width: size
            sourceSize.height: size

            ParallelAnimation {
                running: true

                ScaleAnimator {
                    target: logo
                    from: 0
                    to: 1.0
                    duration: 700
                }

                SequentialAnimation {
                    loops: Animation.Infinite

                    ScaleAnimator {
                        target: logo
                        from: 0.8
                        to: 1.1
                        duration: 1000
                    }
                    ScaleAnimator {
                        target: logo
                        from: 1
                        to: 0.8
                        duration: 1000
                    }
                }
            }
        
        }


        Rectangle {
            radius: 4
            color: "#bec4d0"
            opacity: 0.9
            y: parent.height - (parent.height - logo.y) / 3 - height/2
            anchors.horizontalCenter: parent.horizontalCenter
            height: 6
            width: height*32
            Rectangle {
                radius: 3
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                width: (parent.width / 6) * (stage - 0.00)
                color: "#004080"
                Behavior on width { 
                    PropertyAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
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
        easing.type: Easing.InOutQuad
    }
}
