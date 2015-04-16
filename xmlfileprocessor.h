/*
 * Copyright (C) 2013-2015 Atmel Corporation.
 *
 * This file is licensed under the terms of the Atmel LIMITED License Agreement
 * as written in the COPYING file that is delivered in the project root directory.
 *
 * DISCLAIMER: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
 * See the COPYING license file for more details.
 */

#ifndef XMLFILEPROCESSOR_H
#define XMLFILEPROCESSOR_H

#include <QObject>

class XMLFileProcessor : public QObject
{
    Q_OBJECT
public:
    explicit XMLFileProcessor(QObject *parent = 0);
    void processFiles();
};

#endif // XMLFILEPROCESSOR_H
