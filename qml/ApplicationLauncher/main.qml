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

Rectangle {
    id: canvas
    width: wqvga ? 480 : 800
    height: wqvga ? 272 : 480
    color: "#464646"
    RssModel { id: rssModel }
    ListView {
        id: flickable
        keyNavigationWraps: false
        boundsBehavior: Flickable.DragAndOvershootBounds
        flickableDirection: Flickable.HorizontalFlick
        highlightMoveVelocity: -1
        interactive: false
        smooth: false
        anchors.fill: parent
        focus: false
        highlightRangeMode: ListView.StrictlyEnforceRange
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        model: rssModel
        delegate: Page { }
    }
}
