#include "AudioToggle.h"
#include <QAudio>
        #include <QMediaPlayer>
        #include <QAudioCaptureSource>
        #include <QMediaRecorder>
        #include <QFileDialog>
        #include <QFile>
        #include <QAudioEncoderSettings>

        AudioToggle::AudioToggle()
        {
            audioSource = new QAudioCaptureSource();
            capture = new QMediaRecorder(audioSource);

                QAudioEncoderSettings audioSettings;
                audioSettings.setCodec("audio/vorbis");
                audioSettings.setQuality(QtMultimediaKit::HighQuality);
                capture->setEncodingSettings(audioSettings);
                capture->setOutputLocation(QUrl::fromLocalFile(":\\test.wav"));
        }

        AudioToggle::~AudioToggle()
        {
delete audioSource;
delete capture;
}

        void AudioToggle::record()
        {
            capture->record();
        }

        void AudioToggle::stop()
        {
            capture->stop();
        }
        void AudioToggle::pause()
        {
            capture->pause();
        }

        void AudioToggle::play()
        {
            QMediaPlayer *player = new QMediaPlayer;
            QUrl url = QUrl::fromLocalFile(":\\test.wav");
            player->setMedia(url);
            player->setVolume(100);
            player->play();
        }
