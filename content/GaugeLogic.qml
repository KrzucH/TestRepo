import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Timeline
import QtQuick.Studio.LogicHelper 1.0



GaugeTestForm {

    property double speed: 0
    property int rpm: 0

    Rectangle {
        id:rpmGauge
        x: 271
        y: 349
        width: 50
        height: 50
        rotation: { if(speed >= 200 && speed < 290) {
                        speed / 1.5 } else if(speed >= 290 && speed < 395) {
                        speed / 2 } else if (speed >= 395 && speed < 570) {
                        speed / 3 } else if (speed >= 570 && speed < 760) {
                        speed / 4 } else if (speed >= 760) {
                        speed / 5 } else {
                        speed }
              }
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
        rotation: speed / 4
        color:"transparent"
        Image {
            id: wskazowka_02_PNG
            x: -163
            y: 29
            source: "../Gaugespictures/Wskazowka_02_PNG.png"
            rotation: 0
            fillMode: Image.PreserveAspectFit
        }
    }

//    Timeline {
//        id: timeline
//        animations: [
//            TimelineAnimation {
//                id: timelineAnimation
//                pingPong: true
//                loops: -1
//                duration: 7000
//                running: true
//                to: 1000
//                from:500
//            }
//        ]
//        startFrame: 0
//        endFrame: 1000
//        enabled: true

//        KeyframeGroup {
//            target: rpmGauge
//            property: "rotation"
//            Keyframe {
//                value: 200
//                frame: 1000
//            }

//            Keyframe {
//                value: -200
//                frame: 0
//            }
//        }
//    }

//    Item {
//        id:upKey
//        anchors.fill: parent
//        focus: true

//        Keys.onUpPressed:{
//            if(speed >= 195) {
//                speed
//            } else {
//                speed = speed + 0.6
//            }
//        }

//        Keys.onDownPressed:{
//            if(speed <= 0) {
//                speed
//            } else {
//                speed = speed - 0.6
//            }
//        }

//        Keys.onReleased:{
//            if(speed == endSpeed){
//                speed = 100
//            }
//            endSpeed = speed

//        }
//    }

    Text {
        id: text1
        x: 600
        y: 447
        width: 91
        height: 61
        color: "#ffffff"
        text:  stringMapper.text
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
            outputMaximum: 345
            inputMaximum: 1700
            input: speed
        }
    }

    Text {
        id: text2
        x: 600
        y: 559
        width: 91
        height: 61
        color: "#ffffff"
        text: { if(stringMapper2.text == "0") {
                "N"} else { stringMapper2.text }
            }

        font.pixelSize: 50
        horizontalAlignment: Text.AlignHCenter
        font.family: "Agency FB"

        StringMapper {
            id: stringMapper2
            input: { if(rangeMapper1.output >= 40 && rangeMapper1.output < 59) {
                        2 } else if (rangeMapper1.output >= 59 && rangeMapper1.output < 80) {
                        3 } else if (rangeMapper1.output >= 80 && rangeMapper1.output < 115) {
                        4 } else if (rangeMapper1.output >= 115 && rangeMapper1.output < 155) {
                        5 } else if (rangeMapper1.output >= 155) {
                        6 } else if (rangeMapper1.output >= 1 && rangeMapper1.output < 40) {
                        1 } else {
                        0 }
                }
            decimals: 0
        }

        RangeMapper {
            id: rangeMapper1
            outputMaximum: 345
            inputMaximum: 1700
            input: speed
        }
    }

    Button {
        id:button
        x: 48
        y: 50
        text: "Gas"

        Timer {
            id: longPressTimer
            interval: 4 //your press-and-hold interval here
            repeat: false
            running: false
            onTriggered: {
                button.pressAndHold()                
            }
        }

        onPressAndHold: {
            if(pressed){
                if(speed >= 860) {
                    longPressTimer.running = false
                } else {                   
                    speed++
                    longPressTimer.running = true
                }
            }
            else {
                longPressTimer.running = false
            }
        }

        Timer {
            id: decreaseTimer
            interval: 30 //your press-and-hold interval here
            repeat: false
            running: false
            onTriggered: {
                button.released()
            }
        }

        onReleased: {
            if(speed != 0) {
                decreaseTimer.running = true
                speed--
                if(button.pressed) {
                    decreaseTimer.running = false
                }
            } else {
                decreaseTimer.running = false
            }
        }
    }

    Button {
        id: butStop
        x: 140
        y: 50
        text: "Stop"
        Timer {
            id: stopTimer
            interval: 5 //your press-and-hold interval here
            repeat: false
            running: false
            onTriggered: {
                butStop.pressAndHold()
            }
        }

        onPressAndHold: {
            if(pressed){
                if(speed <= 0) {
                    stopTimer.running = false
                } else {
                    speed--
                    stopTimer.running = true
                }
            }
            else {
                stopTimer.running = false
            }
        }

    }

}




