/*
 * Copyright (C) 2013-2015 Atmel Corporation.
 *
 * This file is licensed under the terms of the Atmel LIMITED License Agreement
 * as written in the COPYING file that is delivered in the project root directory.
 *
 * DISCLAIMER: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
 * See the COPYING license file for more details.
 *
 * Software Author: Timesys Corporation (www.timesys.com)
 */

import QtQuick 1.1
import QtAppProcess 0.1

Item {
    id: applicationItem
    width: GridView.view.cellWidth
    height: GridView.view.cellHeight

    function applicationClicked() {
        console.log("clicked  " + applicationName)

        if (!exitTimer.running) {
            process.start()
            exitTimer.start()
        }
    }

    Timer {
          id: exitTimer
          interval: 1000; running: false; repeat: true
          onTriggered: Qt.quit();
    }

    Process {
        id: process
        program: applicationPath // Qt.resolvedUrl(applicationPath)
        arguments: wqvga ? applicationArg + " -smallresolution" : applicationArg

//        onReadyReadStandardError: {
//            console.log("STD ERR: " + process.readAllStandardError())
//        }

//        onReadyReadStandardOutput: {
//            console.log("STD OUT: " + process.readAllStandardOutput())
//        }

//        onStarted: {
//            console.log("Started")
//        }

//        onFinished: {
//            console.log("Finished")
//        }
    }

    Item {
        id: app
        anchors.centerIn: parent
        scale: 0.0

        Behavior on scale { NumberAnimation { duration: 900; easing.type: Easing.InOutQuad} }
        Item {
            width: wqvga ? 180 : 270;
            height: wqvga ? 40 : 60;
            anchors.centerIn: parent
            Column {
                spacing: 5
                Rectangle {
                    id: appRect
                    width: wqvga ? 180 : 270
                    height: wqvga ? 40 : 60
                    color: "#00000000"
                    smooth: true
                    Image {
                        id: thumb
                        source: applicationImage
                        fillMode: Image.PreserveAspectFit
                        clip: true
                        x: 1
                        y: 1
                        width: wqvga ? 180 : 270
                        height: wqvga ? 40 : 60
                        smooth: true
                    }
                    // Image { source: "images/gloss.png" }
                }
            }

            Timer {
                id: stateTimer
                interval: 200;
                repeat: false
                onTriggered: app.state = 'State1'
            }
        }

        Busy { id: load; anchors.centerIn: app }

        states: [
            State {
                name: "Show"; when: thumb.status == Image.Ready
                PropertyChanges { target: app; scale: 1 }
            },
            State {
                name: "Pressed"
                PropertyChanges { target: app; scale: 1.3 }
            },
            State {
                name: "State1"
                PropertyChanges {target: app; scale: 1.0 }
            }
        ]

        transitions: [
            Transition {
                from: "Show"; to: "Start"
                ParentAnimation {
                    via: foreground
                    NumberAnimation { properties: "x,y"; duration: 500; easing.type: Easing.InOutQuad }
                }
            },
            Transition {
                NumberAnimation { properties: "scale"; duration: 200; easing.type: Easing.InOutQuart }
            }
        ]

        Timer {
            id: loadingTimer
            interval: 7000;
            repeat: false
            onTriggered: {
                load.active = 'false'
                console.log("STD_ERR: " + process.readAllStandardError()
                            + "STD OUT: " + process.readAllStandardOutput())
            }
        }
    }

    MouseArea {
        anchors.fill: applicationItem;
        onClicked: {
            app.state = "Pressed"
            load.active = 'true'
            stateTimer.start()
            loadingTimer.start()
            applicationClicked()
        }
    }
}
