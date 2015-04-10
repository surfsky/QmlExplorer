TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    extension/utils.cpp \
    extension/QuickWidgetButton.cpp \
    extension/imageProcessor.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

OTHER_FILES += \
    extension/_TestFileIO.qml \
    extension/TestCallQml.qml \
    extension/TestQtObject_ObjectName.qml \
    Task.txt \
    extension/TestQuickWidgetButton.qml \
    extension/qmldir. \
    extension/TestImageProcessor.qml

HEADERS += \
    extension/imageProcessor.h

DISTFILES += \
    extension/_TestClipboard.qml
