TEMPLATE = app

QT += qml quick opengl
CONFIG += c++11

SOURCES += main.cpp \
    fileio.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    translation_directions.json \
    langv_code.txt \
    ../../Документы/iso_country.txt \
    setting.txt \
    ../../Загрузки/скачанные файлы.png \
    ../../Загрузки/скачанные файлы.png \
    скачанные файлы.png \
    changeDiraction.png

HEADERS += \
    fileio.h

