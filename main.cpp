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
#include <QTimer>
#include "qmlapplicationviewer.h"
#include "process.h"
#include "xmlfileprocessor.h"
#include <QQmlContext>

bool wqvga;

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QString current;
    QString currentName;
    QString currentVal;
    int idxOf=0;
    bool multifile = false;

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
            else if(currentName.contains(QString("multifile")))
            {
                multifile = true;
            }
        }
    }

    QScopedPointer<QApplication> app(createApplication(argc, argv));

    if (multifile)
    {
        XMLFileProcessor fProcessor;
        fProcessor.processFiles();
    }

    qmlRegisterType<Process>("QtAppProcess", 0, 1, "Process");

    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    QQmlContext *ctxt = viewer.rootContext();
    ctxt->setContextProperty("wqvga", wqvga);
    viewer.setMainQmlFile(QLatin1String("qml/ApplicationLauncher/main.qml"));

    // This is a *magic* hack to get rid of a blank screen at startup. Probably
    // a better way to do this.
    QTimer::singleShot(2000, [&viewer] {
            viewer.showFullScreen();
            //viewer.show();
	    });

    qApp->setOverrideCursor( QCursor( Qt::BlankCursor ) );

    return app->exec();
}
