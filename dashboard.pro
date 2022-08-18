TEMPLATE = app
TARGET = display
INCLUDEPATH += .
QT += quick
QT += serialbus

SOURCES += \
    main.cpp

RESOURCES += \
    dashboard.qrc

OTHER_FILES += \
    qml/dashboard.qml \
    qml/DashboardGaugeStyle.qml \
    qml/IconGaugeStyle.qml \
    qml/SpeedometerStyle.qml \
    qml/TachometerStyle.qml \
    qml/TurnIndicator.qml \
    qml/ValueSource.qml

target.path = /home/pi/pidgc
INSTALLS += target
