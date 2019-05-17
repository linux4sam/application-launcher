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

import QtQuick 2.3
import QtQuick.XmlListModel 2.12

Component {
    Item {
        property bool cond: true;
        id: page
        width: ListView.view.width;
        height: ListView.view.height

        Image {
            smooth: false
            source: wqvga ? "../../resources/background-wqvga.jpg" : "../../resources/background.jpg"
            clip: true
        }

        XmlListModel {
            id: innerModel

            source: "../../applications_list.xml"
            query: "/feed/screen[@id='Screen " + (flickable.currentIndex + 1) + "']/entry"
            namespaceDeclarations: "declare default element namespace 'http://www.w3.org/2005/Atom';"

            XmlRole { name: "applicationName"; query: "title/string()" }
            XmlRole { name: "applicationDescription"; query: "description/string()" }
            XmlRole { name: "applicationImage"; query: "link[@rel='enclosure']/@href/string()" }
            XmlRole { name: "applicationPath"; query: "path/@exec/string()" }
            XmlRole { name: "applicationArg"; query: "arg/string()" }
        }

        GridView {
            id: grid_view_front
            x: wqvga ? 70 : 100
            y: wqvga ? 30 : 40
            width: wqvga ? 400 : 650
            height: wqvga ? 250 : 400
            interactive: false
            flickableDirection: Flickable.HorizontalFlick
            highlightMoveDuration: -1
            highlightFollowsCurrentItem: false
            keyNavigationWraps: true
            highlightRangeMode: GridView.NoHighlightRange
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            contentHeight: wqvga ? 40 : 60
            contentWidth: wqvga ? 180 : 270
            cellHeight: wqvga ? 65: 100
            cellWidth: wqvga ? 200 : 325
            delegate: ApplicationDelegate {}
            model: innerModel
        }

        Image {
            id: imageRight
            width: 38
            height: 40
            anchors.right: parent.right
            anchors.rightMargin: wqvga ? 10 : 30
            anchors.verticalCenter: wqvga ? undefined : parent.verticalCenter
            anchors.bottom: wqvga ? parent.bottom : undefined
            anchors.bottomMargin: wqvga ? 20 : 0
            source: "../../resources/arrow-right.png"
            visible: ((flickable.currentIndex+1) < flickable.count) ? true : false

            MouseArea {
                id: mouse_area_right_arrow
                x: 0
                y: -40
                width: 38
                height: 123
                onClicked: flickable.incrementCurrentIndex();
            }
        }

        Image {
            id: imageLeft
            width: 38
            height: 40
            anchors.left: parent.left
            anchors.leftMargin: wqvga ? 10 : 30
            anchors.verticalCenter: wqvga ? undefined : parent.verticalCenter
            anchors.bottom: wqvga ? parent.bottom : undefined
            anchors.bottomMargin: wqvga ? 20 : 0

            source: "../../resources/arrow-left.png"
            visible: (flickable.currentIndex+1>1) ? true : false

            MouseArea {
                id: mouse_area_left_arrow
                x: 0
                y: -40
                width: 38
                height: 123
                onClicked: flickable.decrementCurrentIndex();
            }
        }
    }
}
