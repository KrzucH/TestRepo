/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Timeline
import QtQuick.Studio.LogicHelper 1.0



Item {
    id:carGauge
    width: 1024
    height: 758

    Image {
        id: wskazniki_PNG
        x: 99
        y: 128
        source: "../Gaugespictures/Wskazniki_PNG.png"
        fillMode: Image.PreserveAspectFit
    }


    Rectangle {
        id:rpmGauge
        x: 271
        y: 349
        width: 50
        height: 50
        rotation: -171.556
        radius: 60
        color: "transparent"
        Image {
            id: wskazowka_01_PNG
            x:17
            y:49
            source: "../Gaugespictures/Wskazowka_01_PNG.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle{
        id:speedGauge
        x: 620
        y: 356
        width: 50
        height: 50
        radius: width
        rotation: -1.018
        color:"transparent"
        Image {
            id: wskazowka_02_PNG
            x: -90
            y: -117
            source: "../Gaugespictures/Wskazowka_02_PNG.png"
            rotation: 90
            fillMode: Image.PreserveAspectFit
        }
    }

    Timeline {
        id: timeline
        animations: [
            TimelineAnimation {
                id: timelineAnimation
                pingPong: true
                loops: -1
                duration: 7000
                running: true
                to: 1000
                from:500
            }
        ]
        startFrame: 0
        endFrame: 1000
        enabled: true

        KeyframeGroup {
            target: rpmGauge
            property: "rotation"
            Keyframe {
                value: 200
                frame: 1000
            }

            Keyframe {
                value: -200
                frame: 0
            }
        }
    }

    Timeline {
        id: timeline2
        animations: [
            TimelineAnimation {
                id: timelineAnimation2
                pingPong: true
                loops: -1
                duration: 7000
                running: true
                to: 1000
                from: 0
            }
        ]
        startFrame: 0
        endFrame: 1000
        enabled: true

        KeyframeGroup {
            target: speedGauge
            property: "rotation"
            Keyframe {
                value: 110
                frame: 1000
            }

            Keyframe {
                value: -90
                frame: 0
            }
        }
    }

    Text {
        id: text1
        x: 600
        y: 447
        width: 91
        height: 61
        color: "#ffffff"
        text: stringMapper.text
        font.pixelSize: 45

        horizontalAlignment: Text.AlignHCenter
        font.family: "Agency FB"

        StringMapper {
            id: stringMapper
            input: rangeMapper.output
            decimals: 0
        }

        RangeMapper {
            id: rangeMapper
            outputMaximum: 160
            inputMaximum: 1000
            input: timeline2.currentFrame
        }
    }

}
