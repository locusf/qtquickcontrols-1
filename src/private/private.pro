CXX_MODULE = qml
TARGET  = privateplugin
TARGETPATH = QtDesktop/Private

QT += qml quick widgets gui-private core-private

HEADERS += \
    $$PWD/qquickcomponentsprivate_p.h \
    $$PWD/qprivateplugin_p.h\
    $$PWD/qrangemodel_p.h \
    $$PWD/qrangemodel_p_p.h \
    $$PWD/qwheelarea_p.h \
    $$PWD/qstyleitem_p.h \
    $$PWD/qtsplitterbase_p.h

SOURCES += \
    $$PWD/qquickcomponentsprivate.cpp \
    $$PWD/qprivateplugin.cpp\
    $$PWD/qstyleitem.cpp \
    $$PWD/qrangemodel.cpp\
    $$PWD/qwheelarea.cpp \
    $$PWD/qtsplitterbase.cpp

OTHER_FILES += \
    $$PWD/privateplugin.json

# private qml files
QML_FILES += \
    TabBar.qml \
    BasicButton.qml \
    ButtonBehavior.qml \
    ModalPopupBehavior.qml \
    PageSlideTransition.qml \
    PageStack.js \
    ScrollAreaHelper.qml \
    Splitter.qml \
    ScrollBar.qml \
    FocusFrame.qml

mac {
    LIBS += -framework Carbon
}

load(qml_plugin)
