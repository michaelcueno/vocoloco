/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/

#ifndef DUMMYDESKTOPPLAYER_H
#define DUMMYDESKTOPPLAYER_H
#include <QString>
#include <QDebug>

/**
 * @brief This is just a mediator for the compiler for the desktop build
 *
 *
 * This class is meant only as a mediator for the desktop build so that the complier doesn't complain
 *  about not having the correct functions for dealing with audio files (since we are not on android)
 */
class DummyDesktopPlayer
{
public:
    DummyDesktopPlayer(QString type);
    ~DummyDesktopPlayer();
    bool playerSetUrl(const QString &url);
    bool play();
    bool playerPause();
    bool playerStop();

    // Recorder functions
    bool recorderSetUrl(const QString &url);
    bool record();
    bool recorderStop();

    static QString type;


};

#endif // DUMMYDESKTOPPLAYER_H
