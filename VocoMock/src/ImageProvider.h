/****************************************************************************
 * Copyright (C) 2012 Michael Cueno
 * Contact: mcueno2@uic.edu
 ****************************************************************************/

#include <QDeclarativeImageProvider>
#include <QNetworkAccessManager>
#include <QDebug>


/**
 * @brief This may not be needed!
 */
class ImageProvider: public QDeclarativeImageProvider
{
public:
    ImageProvider(QNetworkAccessManager* manager)
        : QDeclarativeImageProvider(QDeclarativeImageProvider::Pixmap),
          mManager(manager)
    {}

    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize)
    {
        qDebug() <<"Pixmap requested";
        int width = 320;
        int height = 53;

        QPixmap result;

        QPixmap pixmap(requestedSize.width() > 0 ? requestedSize.width():width,
             requestedSize.height() > 0 ?requestedSize.height():height);

            pixmap.fill(QColor(id).rgba());

            if ( size ) *size = QSize(width, height);
            result = pixmap;

        return result;
    }

private:
    QNetworkAccessManager* mManager;
};
