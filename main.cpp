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

#include <QtGlobal>
#if (QT_VERSION >= 0x050000)
#include <QApplication>
#else
#include <QtGui/QApplication>
#endif // (QT_VERSION >= 0x050000)
#include <QtDeclarative/qdeclarative.h>
#include <QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "process.h"
#include "xmlfileprocessor.h"

bool wqvga;

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QString current;
    QString currentName;
    QString currentVal;
    int idxOf=0;

    wqvga = false;

    /* Parse command line arguments */
    for(int i=0; i<argc; i++)
    {
        current = argv[i];
        idxOf = current.indexOf("=");
        if(idxOf == -1)
        {
            currentName = current;
            currentVal = QString();
        }else{
            currentName = current.left(idxOf);
            currentVal = current.mid(idxOf+1);
        }

        if(currentName.count())
        {
            if(currentName.contains(QString("WQVGA")))
            {
                wqvga = true;
            }
        }
    }

    QScopedPointer<QApplication> app(createApplication(argc, argv));

    // When we final release, we can write this file manually
    //XMLFileProcessor fProcessor;
    //fProcessor.processFiles();

    qmlRegisterType<Process>("QtAppProcess", 0, 1, "Process");

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    QDeclarativeContext *ctxt = viewer.rootContext();
    ctxt->setContextProperty("wqvga", wqvga);
    viewer.setMainQmlFile(QLatin1String("qml/ApplicationLauncher/main.qml"));
    viewer.showFullScreen();
//    viewer.show();
    qApp->setOverrideCursor( QCursor( Qt::BlankCursor ) );

    return app->exec();
}
