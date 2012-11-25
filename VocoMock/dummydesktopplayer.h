#ifndef DUMMYDESKTOPPLAYER_H
#define DUMMYDESKTOPPLAYER_H
#include <QString>
#include <QDebug>

/**
 * This class is meant only as a mediator for the desktop build so that the complier doesn't complain
 *  about not having the correct functions for dealing with audio files
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
