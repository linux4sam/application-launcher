/*
 * Copyright (C) 2013-2015 Atmel Corporation.
 *
 * This file is licensed under the terms of the Atmel LIMITED License Agreement
 * as written in the COPYING file that is delivered in the project root directory.
 *
 * DISCLAIMER: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.
 * See the COPYING license file for more details.
 */

#ifndef PROCESS_H
#define PROCESS_H

#include <QtCore/QObject>
#include <QtCore/QStringList>

class Process : public QObject
{
    Q_OBJECT
    Q_DISABLE_COPY(Process)
    Q_PROPERTY(QString program READ program WRITE setProgram NOTIFY programChanged)
    Q_PROPERTY(QStringList arguments READ arguments WRITE setArguments NOTIFY argumentsChanged)
public:
    Process(QObject *parent = 0);
    ~Process();

    const QString &program() const;
    const QStringList &arguments() const;

    Q_INVOKABLE QByteArray readAllStandardError();
    Q_INVOKABLE QByteArray readAllStandardOutput();

public slots:
    void setProgram(const QString &program);
    void setArguments(const QStringList &arguments);

    void start();
    void terminate();
    void kill();

signals:
    void programChanged(const QString &program);
    void argumentsChanged(const QStringList &arguments);

//    void error(QProcess::ProcessError error )
    void finished(int exitCode);
    void readyReadStandardError();
    void readyReadStandardOutput();
    void started();
//    void stateChanged(QProcess::ProcessState newState);

private:
    class Private;
    Private *d;
};

#endif // PROCESS_H

