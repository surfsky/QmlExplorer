# BASIC
TEMPLATE = app
TARGET = QMLExplorer
QT += core gui widgets qml quick sensors sql multimedia webengine 3dquick
#CONFIG += console


# C++
QMAKE_CXXFLAGS += -std=c++11
HEADERS += \
    QmlExtension/Highlighter/QMLHighlighter.h \
    QmlExtension/Highlighter/SyntaxHighlighter.h \
    mainwindow.h \
    QmlExtension/winmessage.h
SOURCES += main.cpp \
    QmlExtension/Highlighter/QMLHighlighter.cpp \
    QmlExtension/winmessage.cpp

# RES
RESOURCES += \
    Test/test.qrc \
    Qml/qml.qrc \
    App/app.qrc \
    Assets/assets.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =


# Default rules for deployment.
include(deployment.pri)


# icon
ICON = assets/icons/icon64.png
macx: ICON = assets/icons/icon.icns
win32: RC_FILE = assets/icons/window.rc


# FILES
OTHER_FILES += \
    task.txt


ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

DISTFILES += \
    Test/Qt3D/readme.txt



