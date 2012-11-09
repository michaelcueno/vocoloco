#include <QUrl>
#include <QObject>
#include <QAudioFormat>
#include <QAudioCaptureSource>
#include <QMediaRecorder>

class AudioToggle : public QObject
{
    Q_OBJECT

public:
     AudioToggle();
    ~ AudioToggle();

public slots:
    void stop();
    void play();
    void record();

private:
    QAudioCaptureSource *audioSource;
    QMediaRecorder *capture;
};
