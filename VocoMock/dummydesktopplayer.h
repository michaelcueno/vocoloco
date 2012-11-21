#ifndef DUMMYDESKTOPPLAYER_H
#define DUMMYDESKTOPPLAYER_H
#include <QString>
#include <QDebug>

class DummyDesktopPlayer
{
public:
    DummyDesktopPlayer();
    ~DummyDesktopPlayer();
    bool setUrl(const QString &url);
    bool play();
    bool pause();
    bool stop();

};

#endif // DUMMYDESKTOPPLAYER_H
