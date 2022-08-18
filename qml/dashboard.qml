/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.2
import QtQuick.Window 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4

Window {
    id: root
    visible: true
    width: 1024
    height: 768

    color: "#161616"
    //title: "Qt Quick Extras Demo"

    ValueSource {
        id: valueSource
    }

    // Dashboards are typically in a landscape orientation, so we need to ensure
    // our height is never greater than our width.
    Item {
        id: container
        width: root.width
        height: Math.min(root.width, root.height)
        anchors.centerIn: parent
        rotation: -90

        Row {
            id: gaugeRow
            anchors.centerIn: parent

            Item {
                width: container.width
                height: container.height

                SpeedometerStyle {
                    id: speedometer
                    value: valueSource.kph
                    anchors.verticalCenter: parent.verticalCenter
                    width: container.width
                    height: container.height
                }

                Rectangle {
                    id: highbeamIcon
                    width: 34
                    height: 24
                    color: "transparent"
                    x: 420
                    y: -30
                    visible: valueSource.highbeam

                    Image {
                        source: "qrc:/images/high_beam.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Rectangle {
                    id: lowbeamIcon
                    width: 34
                    height: 24
                    color: "transparent"
                    x: 570
                    y: -30
                    visible: valueSource.lowbeam

                    Image {
                        source: "qrc:/images/low_beam.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Item {
                    //width: 20
                    //height: 20
                    y: 450
                    x: 50
                    CircularGauge {
                        id: fuelGauge
                        value: valueSource.fuel
                        maximumValue: 1

                        style: CircularGaugeStyle {
                            id: fuelGaugeStyle
                            minimumValueAngle: 128
                            maximumValueAngle: 46

                            function toPixels(percentage) {
                                return percentage * outerRadius;
                            }

                            needle: Canvas {
                                implicitWidth: outerRadius * 0.1
                                implicitHeight: outerRadius

                                property real needleLength: outerRadius
                                property real needleTipWidth: toPixels(0.02)
                                property real needleBaseWidth: toPixels(0.05)

                                property real xCenter: width / 2
                                property real yCenter: height / 2

                                onPaint: {
                                    var ctx = getContext("2d");
                                    ctx.reset();

                                    ctx.beginPath();
                                    ctx.moveTo(xCenter, height);
                                    ctx.lineTo(xCenter - needleBaseWidth / 2, height - needleBaseWidth / 2);
                                    ctx.lineTo(xCenter - needleTipWidth / 2, 0);
                                    ctx.lineTo(xCenter, yCenter - needleLength);
                                    ctx.lineTo(xCenter, 0);
                                    ctx.closePath();
                                    ctx.fillStyle = Qt.rgba(0.66, 0.3, 0, 1);
                                    ctx.fill();

                                    ctx.beginPath();
                                    ctx.moveTo(xCenter, height)
                                    ctx.lineTo(width, height - needleBaseWidth / 2);
                                    ctx.lineTo(xCenter + needleTipWidth / 2, 0);
                                    ctx.lineTo(xCenter, 0);
                                    ctx.closePath();
                                    ctx.fillStyle = Qt.lighter(Qt.rgba(0.8, 0.2, 0, 1));
                                    ctx.fill();
                                }
                            }
                        }
                    }
                }

                Item {
                    //width: 20
                    //height: 20
                    y: 40
                    x: 50
                    CircularGauge {
                        id: tempGauge
                        value: valueSource.temperature
                        maximumValue: 1

                        style: CircularGaugeStyle {
                            id: tempGaugeStyle
                            minimumValueAngle: 135
                            maximumValueAngle: 40

                            function toPixels(percentage) {
                                return percentage * outerRadius;
                            }

                            needle: Canvas {
                                implicitWidth: outerRadius * 0.1
                                implicitHeight: outerRadius

                                property real needleLength: outerRadius
                                property real needleTipWidth: toPixels(0.02)
                                property real needleBaseWidth: toPixels(0.05)

                                property real xCenter: width / 2
                                property real yCenter: height / 2

                                onPaint: {
                                    var ctx = getContext("2d");
                                    ctx.reset();

                                    ctx.beginPath();
                                    ctx.moveTo(xCenter, height);
                                    ctx.lineTo(xCenter - needleBaseWidth / 2, height - needleBaseWidth / 2);
                                    ctx.lineTo(xCenter - needleTipWidth / 2, 0);
                                    ctx.lineTo(xCenter, yCenter - needleLength);
                                    ctx.lineTo(xCenter, 0);
                                    ctx.closePath();
                                    ctx.fillStyle = Qt.rgba(0.66, 0.3, 0, 1);
                                    ctx.fill();

                                    ctx.beginPath();
                                    ctx.moveTo(xCenter, height)
                                    ctx.lineTo(width, height - needleBaseWidth / 2);
                                    ctx.lineTo(xCenter + needleTipWidth / 2, 0);
                                    ctx.lineTo(xCenter, 0);
                                    ctx.closePath();
                                    ctx.fillStyle = Qt.lighter(Qt.rgba(0.8, 0.2, 0, 1));
                                    ctx.fill();
                                }
                            }
                        }
                    }
                }

                Item {
                    //width: 20
                    //height: 20
                    y: 28
                    x: 640
                    CircularGauge {
                        id: boostGauge
                        value: valueSource.boost
                        maximumValue: 1

                        style: CircularGaugeStyle {
                            id: boostGaugeStyle
                            minimumValueAngle: -145
                            maximumValueAngle: -35

                            function toPixels(percentage) {
                                return percentage * outerRadius;
                            }

                            needle: Canvas {
                                implicitWidth: outerRadius * 0.1
                                implicitHeight: outerRadius

                                property real needleLength: outerRadius
                                property real needleTipWidth: toPixels(0.02)
                                property real needleBaseWidth: toPixels(0.05)

                                property real xCenter: width / 2
                                property real yCenter: height / 2

                                onPaint: {
                                    var ctx = getContext("2d");
                                    ctx.reset();

                                    ctx.beginPath();
                                    ctx.moveTo(xCenter, height);
                                    ctx.lineTo(xCenter - needleBaseWidth / 2, height - needleBaseWidth / 2);
                                    ctx.lineTo(xCenter - needleTipWidth / 2, 0);
                                    ctx.lineTo(xCenter, yCenter - needleLength);
                                    ctx.lineTo(xCenter, 0);
                                    ctx.closePath();
                                    ctx.fillStyle = Qt.rgba(0.66, 0.3, 0, 1);
                                    ctx.fill();

                                    ctx.beginPath();
                                    ctx.moveTo(xCenter, height)
                                    ctx.lineTo(width, height - needleBaseWidth / 2);
                                    ctx.lineTo(xCenter + needleTipWidth / 2, 0);
                                    ctx.lineTo(xCenter, 0);
                                    ctx.closePath();
                                    ctx.fillStyle = Qt.lighter(Qt.rgba(0.8, 0.2, 0, 1));
                                    ctx.fill();
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    id: oilPressureIcon
                    width: 61
                    height: 24
                    color: "transparent"
                    x: 685
                    y: 720
                    visible: valueSource.oillight

                    Image {
                        opacity: valueSource.oillight
                        source: "qrc:/images/oil.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Item {
                    y: 435
                    x: 640
                    CircularGauge {
                        id: oilGauge
                        value: valueSource.oil
                        maximumValue: 1

                        style: CircularGaugeStyle {
                            id: oilGaugeStyle
                            minimumValueAngle: -135
                            maximumValueAngle: -45

                            function toPixels(percentage) {
                                return percentage * outerRadius;
                            }

                            needle: Canvas {
                                implicitWidth: outerRadius * 0.1
                                implicitHeight: outerRadius

                                property real needleLength: outerRadius
                                property real needleTipWidth: toPixels(0.02)
                                property real needleBaseWidth: toPixels(0.05)

                                property real xCenter: width / 2
                                property real yCenter: height / 2

                                onPaint: {
                                    var ctx = getContext("2d");
                                    ctx.reset();

                                    ctx.beginPath();
                                    ctx.moveTo(xCenter, height);
                                    ctx.lineTo(xCenter - needleBaseWidth / 2, height - needleBaseWidth / 2);
                                    ctx.lineTo(xCenter - needleTipWidth / 2, 0);
                                    ctx.lineTo(xCenter, yCenter - needleLength);
                                    ctx.lineTo(xCenter, 0);
                                    ctx.closePath();
                                    ctx.fillStyle = Qt.rgba(0.66, 0.3, 0, 1);
                                    ctx.fill();

                                    ctx.beginPath();
                                    ctx.moveTo(xCenter, height)
                                    ctx.lineTo(width, height - needleBaseWidth / 2);
                                    ctx.lineTo(xCenter + needleTipWidth / 2, 0);
                                    ctx.lineTo(xCenter, 0);
                                    ctx.closePath();
                                    ctx.fillStyle = Qt.lighter(Qt.rgba(0.8, 0.2, 0, 1));
                                    ctx.fill();
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    id: gaugeForeground
                    width: 768
                    height: 1024
                    color: "transparent"
                    x: parent.width / 2 - width / 2
                    y: parent.height / 2 - height / 2

                    Image {
                        source: "qrc:/images/gauge_foreground.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }

                TurnIndicator {
                    id: leftIndicator
                    //anchors.verticalCenter: parent.verticalCenter
                    x: 265
                    y: -70
                    //width: height
                    //height: container.height * 0.1

                    direction: "left"
                    on: valueSource.turnSignal === -1 //Qt.LeftArrow
                }

                TurnIndicator {
                    id: rightIndicator
                    //anchors.verticalCenter: parent.verticalCenter
                    x: 760
                    y: 45
                    //width: height
                    //height: container.height * 0.1

                    direction: "right"
                    on: valueSource.turnSignal === -1 //Qt.LeftArrow
                }

                Rectangle {
                    id: coolantTemperatureIcon
                    width: 34
                    height: 30
                    color: "transparent"
                    x: 300
                    y: 340
                    visible: valueSource.templight

                    Image {
                        source: "qrc:/images/coolant.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Rectangle {
                    id: fuelLevelIcon
                    width: 23
                    height: 29
                    color: "transparent"
                    x: 300
                    y: 720
                    visible: valueSource.fuellight

                    Image {
                        source: "qrc:/images/fuel.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }


            }
        }

       /* Row {
            id: gaugeRow
            spacing: container.width * 0.02
            anchors.centerIn: parent

            TurnIndicator {
                id: leftIndicator
                anchors.verticalCenter: parent.verticalCenter
                width: height
                height: container.height * 0.1 - gaugeRow.spacing

                direction: Qt.LeftArrow
                on: valueSource.turnSignal == Qt.LeftArrow
            }

            Item {
                width: height
                height: container.height * 0.25 - gaugeRow.spacing
                anchors.verticalCenter: parent.verticalCenter

                CircularGauge {
                    id: fuelGauge
                    value: valueSource.fuel
                    maximumValue: 1
                    y: parent.height / 2 - height / 2 - container.height * 0.01
                    width: parent.width
                    height: parent.height * 0.7

                    style: IconGaugeStyle {
                        id: fuelGaugeStyle

                        icon: "qrc:/images/fuel-icon.png"
                        minWarningColor: Qt.rgba(0.5, 0, 0, 1)

                        tickmarkLabel: Text {
                            color: "white"
                            visible: styleData.value === 0 || styleData.value === 1
                            font.pixelSize: fuelGaugeStyle.toPixels(0.225)
                            text: styleData.value === 0 ? "E" : (styleData.value === 1 ? "F" : "")
                        }
                    }
                }

                CircularGauge {
                    value: valueSource.temperature
                    maximumValue: 1
                    width: parent.width
                    height: parent.height * 0.7
                    y: parent.height / 2 + container.height * 0.01

                    style: IconGaugeStyle {
                        id: tempGaugeStyle

                        icon: "qrc:/images/temperature-icon.png"
                        maxWarningColor: Qt.rgba(0.5, 0, 0, 1)

                        tickmarkLabel: Text {
                            color: "white"
                            visible: styleData.value === 0 || styleData.value === 1
                            font.pixelSize: tempGaugeStyle.toPixels(0.225)
                            text: styleData.value === 0 ? "C" : (styleData.value === 1 ? "H" : "")
                        }
                    }
                }
            }

            CircularGauge {
                id: speedometer
                value: valueSource.kph
                anchors.verticalCenter: parent.verticalCenter
                maximumValue: 280
                // We set the width to the height, because the height will always be
                // the more limited factor. Also, all circular controls letterbox
                // their contents to ensure that they remain circular. However, we
                // don't want to extra space on the left and right of our gauges,
                // because they're laid out horizontally, and that would create
                // large horizontal gaps between gauges on wide screens.
                width: height
                height: container.height * 0.5

                style: DashboardGaugeStyle {}
            }

            CircularGauge {
                id: tachometer
                width: height
                height: container.height * 0.25 - gaugeRow.spacing
                value: valueSource.rpm
                maximumValue: 8
                anchors.verticalCenter: parent.verticalCenter

                style: TachometerStyle {}
            }

            TurnIndicator {
                id: rightIndicator
                anchors.verticalCenter: parent.verticalCenter
                width: height
                height: container.height * 0.1 - gaugeRow.spacing

                direction: Qt.RightArrow
                on: valueSource.turnSignal == Qt.RightArrow
            }

        }
    */
    }
}
