#include "dummydesktopplayer.h"


DummyDesktopPlayer::DummyDesktopPlayer(QString type){ qDebug() << "Dummy Desktop Player Created";  }
DummyDesktopPlayer::~DummyDesktopPlayer(){ qDebug() << "Dummy Desktop Player Created";  }
bool DummyDesktopPlayer::playerSetUrl(const QString &url){ qDebug() << "Dummy Desktop Player Created";  }
bool DummyDesktopPlayer::play(){ qDebug() << "Dummy Desktop Player Created";  }
bool DummyDesktopPlayer::playerPause(){ qDebug() << "Dummy Desktop Player Created";  }
bool DummyDesktopPlayer::playerStop(){ qDebug() << "Dummy Desktop Player Created";  }

bool DummyDesktopPlayer::recorderSetUrl(const QString &url){ qDebug() << "Dummy Desktop Player Created";  }
bool DummyDesktopPlayer::record(){ qDebug() << "Dummy Desktop Player Created";  }
bool DummyDesktopPlayer::recorderStop(){ qDebug() << "Dummy Desktop Player " ;}
