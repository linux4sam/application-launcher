/*
 * Copyright (C) 2013-2015 Atmel Corporation.
 *
 * This file is licensed under the terms of the Atmel LIMITED License Agreement
 * as written in the COPYING file that is delivered in the project root directory.
 *
 * DISCLAIMER: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
 * See the COPYING license file for more details.
 */

#include "qdatastream.h"
#include "xmlfileprocessor.h"
#include <QFile>
#include <QDir>
#include <QDebug>

XMLFileProcessor::XMLFileProcessor(QObject *parent) :
    QObject(parent)
{
}

void XMLFileProcessor::processFiles()
{
    QDataStream in, init, out;
    int screenNumber = 1;
    int internalCounter = 0;

    QFile result("./applications_list.xml");
    if (!result.open(QIODevice::WriteOnly)) {
        qDebug() << "Can not open for write: " << result.fileName();
        return;
    }
    QFileInfo fir(result);
    qDebug() << "result (W): " << fir.absoluteFilePath();

    out.setDevice(&result);

    QFile initFile("./applications/xml/header.init");
    if (!initFile.open(QIODevice::ReadOnly)) {
        qDebug() << "Can not open for read: " << initFile.fileName();
        return;
    }
    QFileInfo fiinit(initFile);
    qDebug() << "initFile (R): " << fiinit.absoluteFilePath();

    init.setDevice(&initFile);

    char *initData = new char[initFile.size()];
    init.readRawData(initData, initFile.size());
    out.writeRawData(initData, initFile.size());
    delete [] initData;

    out.writeRawData( "<screen id=\"Screen ", 19);
    char c[2];
    sprintf(c, "%d", screenNumber);
    out.writeRawData( c, 1);
    out.writeRawData("\">", 2);

    QDir dir("./applications/xml/");
    QFileInfoList list = dir.entryInfoList(QDir::NoFilter, QDir::Name);

    for (int i = 0; i < list.size(); ++i)
    {
        QFileInfo fileInfo = list.at(i);
        if (fileInfo.absoluteFilePath().endsWith(".xml", Qt::CaseInsensitive))
        {
            internalCounter++;
            if(internalCounter > 6){
                screenNumber++;
                out.writeRawData( "</screen>", 9);
                out.writeRawData( "<screen id=\"Screen ", 19);
                char d[2];
                sprintf(d, "%d", screenNumber);
                out.writeRawData( d, 1);
                out.writeRawData("\">", 2);
                internalCounter = 1;
            }

            QFile inFile(fileInfo.absoluteFilePath());
            if (!inFile.open(QIODevice::ReadOnly))
                 continue;

            QFileInfo fiinFile(inFile);
            qDebug() << "inFile (R): " << fiinFile.absoluteFilePath();

            in.setDevice(&inFile);

            char *data = new char[inFile.size()];
            in.readRawData(data, inFile.size());
            out.writeRawData(data, inFile.size());
            delete [] data;
        }
    }

    out.writeRawData( "</screen>", 9);
    out.writeRawData( "</feed>", 7);
    result.close();
}
