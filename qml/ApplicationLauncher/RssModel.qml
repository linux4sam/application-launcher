/*
 * Copyright (C) 2013-2015 Atmel Corporation.
 *
 * This file is licensed under the terms of the Atmel LIMITED License Agreement
 * as written in the COPYING file that is delivered in the project root directory.
 *
 * DISCLAIMER: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
 * See the COPYING license file for more details.
 */
import QtQuick 1.1

XmlListModel {

    source: "../../applications_list.xml"
    query: "/feed/screen"
    namespaceDeclarations: "declare default element namespace 'http://www.w3.org/2005/Atom';"

    XmlRole { name: "group_id"; query: "@id/string()" }
}
