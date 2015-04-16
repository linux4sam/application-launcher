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

import QtQuick 1.0

Rectangle {
    id: canvas
    width: wqvga ? 480 : 800
    height: wqvga ? 272 : 480
    color: "#464646"
    RssModel { id: rssModel }
    ListView {
        id: flickable
        // pressDelay: 200
        keyNavigationWraps: false
        boundsBehavior: Flickable.DragAndOvershootBounds
        flickableDirection: Flickable.HorizontalFlick
        interactive: false
        smooth: false
        anchors.fill: parent
        focus: false
        highlightRangeMode: ListView.StrictlyEnforceRange
        highlightMoveSpeed: 4000
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        model: rssModel
        delegate: Page { }
    }
}
