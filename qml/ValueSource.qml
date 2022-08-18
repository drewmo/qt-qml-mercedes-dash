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
//! [0]
Item {
    id: valueSource
    property real kph: 0
    property real rpm: 1
    property real fuel: 1
    property real boost: 0.5
    property real oil: 0
    property bool lowbeam: false
    property bool highbeam: false
    property real voltage: 12.4

    property bool oillight: {
        var ol;
        if (oil < 0.25) {
            return true;
        }
        if (oil >= 0.25) {
            return false;
        }
    }

    property bool batterylight: {
        var bl;
        if (voltage < 11) {
            return true;
        }
        if (voltage >= 11) {
            return false;
        }
    }

    property string gear: {
        var g;
        if (kph == 0) {
            return "P";
        }
        if (kph < 30) {
            return "1";
        }
        if (kph < 50) {
            return "2";
        }
        if (kph < 80) {
            return "3";
        }
        if (kph < 100) {
            return "4";
        }
        if (kph < 130) {
            return "5";
        }
    }
    property bool templight: {
    var tl;
        if (temperature >= 0.60) {
            return true;
        }
        if (temperature < 0.60) {
            return false;
        }
    }
    property bool fuellight: {
        var fl;
        if (fuel < 0.10) {
            return true;
        }
        if (fuel >= 0.10) {
            return false;
        }
    }

    property int turnSignal: gear == "P" && !start ? randomDirection() : -1
    property real temperature: 0
    property bool start: true
//! [0]

    function randomDirection() {
        return Math.random() > 0.5 ? Qt.LeftArrow : Qt.RightArrow;
    }

    SequentialAnimation {
        running: true
        loops: 1

        // We want a small pause at the beginning, but we only want it to happen once.
        PauseAnimation {
            duration: 1000
        }

        PropertyAction {
            target: valueSource
            property: "start"
            value: false
        }

        SequentialAnimation {
            loops: Animation.Infinite
//! [1]
            ParallelAnimation {
                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    from: 0
                    to: 30
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    from: 1
                    to: 6.1
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "fuel"
                    easing.type: Easing.InOutSine
                    from: 1
                    to: 0.75
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "temperature"
                    easing.type: Easing.InOutSine
                    from: 0
                    to: 0.5
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "boost"
                    easing.type: Easing.InOutSine
                    from: 0.5
                    to: 1
                    duration: 600
                }
                NumberAnimation {
                    target: valueSource
                    property: "oil"
                    easing.type: Easing.InOutSine
                    from: 0
                    to: 1
                    duration: 1500
                }
            }
//! [1]
            ParallelAnimation {
                // We changed gears so we lost a bit of speed.
                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    from: 30
                    to: 26
                    duration: 600
                }
                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    from: 6
                    to: 2.4
                    duration: 600
                }
                NumberAnimation {
                    target: valueSource
                    property: "boost"
                    easing.type: Easing.InOutSine
                    from: 1
                    to: 0.3
                    duration: 300
                }
            }
            ParallelAnimation {
                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 60
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 5.6
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "fuel"
                    easing.type: Easing.InOutSine
                    from: 0.75
                    to: 0.5
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "boost"
                    easing.type: Easing.InOutSine
                    from: 0.3
                    to: 0.75
                    duration: 600
                }
                NumberAnimation {
                    target: valueSource
                    property: "oil"
                    easing.type: Easing.InOutSine
                    from: 1
                    to: 0
                    duration: 1500
                }
            }
            ParallelAnimation {
                // We changed gears so we lost a bit of speed.
                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 56
                    duration: 600
                }
                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 2.3
                    duration: 600
                }
                NumberAnimation {
                    target: valueSource
                    property: "boost"
                    easing.type: Easing.InOutSine
                    from: 0.75
                    to: 0
                    duration: 300
                }
                NumberAnimation {
                    target: valueSource
                    property: "oil"
                    easing.type: Easing.InOutSine
                    from: 0
                    to: 0.5
                    duration: 600
                }
            }
            ParallelAnimation {
                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 100
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 5.1
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "fuel"
                    easing.type: Easing.InOutSine
                    from: 0.5
                    to: 0.25
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "temperature"
                    easing.type: Easing.InOutSine
                    from: 0.5
                    to: 1
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "boost"
                    easing.type: Easing.InOutSine
                    from: 0
                    to: 0.5
                    duration: 600
                }
            }
            ParallelAnimation {
                // We changed gears so we lost a bit of speed.
                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 96
                    duration: 600
                }
                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 2.2
                    duration: 600
                }
            }

            ParallelAnimation {
                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 125
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 6.2
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "fuel"
                    easing.type: Easing.InOutSine
                    from: 0.25
                    to: 0
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "temperature"
                    easing.type: Easing.InOutSine
                    from: 1
                    to: 0.5
                    duration: 1500
                }
            }

            // Start downshifting.

            // Fifth to fourth gear.
            ParallelAnimation {
                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.Linear
                    to: 100
                    duration: 5000
                }

                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 3.1
                    duration: 5000
                }
                NumberAnimation {
                    target: valueSource
                    property: "fuel"
                    easing.type: Easing.InOutSine
                    from: 0
                    to: 0.25
                    duration: 5000
                }
            }

            // Fourth to third gear.
            NumberAnimation {
                target: valueSource
                property: "rpm"
                easing.type: Easing.InOutSine
                to: 5.5
                duration: 600
            }

            ParallelAnimation {
                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 60
                    duration: 5000
                }
                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 2.6
                    duration: 5000
                }
                NumberAnimation {
                    target: valueSource
                    property: "fuel"
                    easing.type: Easing.InOutSine
                    from: 0.25
                    to: 0.5
                    duration: 5000
                }
            }

            // Third to second gear.
            NumberAnimation {
                target: valueSource
                property: "rpm"
                easing.type: Easing.InOutSine
                to: 6.3
                duration: 600
            }

            ParallelAnimation {
                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 30
                    duration: 5000
                }
                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 2.6
                    duration: 5000
                }
                NumberAnimation {
                    target: valueSource
                    property: "fuel"
                    easing.type: Easing.InOutSine
                    from: 0.5
                    to: 0.75
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "temperature"
                    easing.type: Easing.InOutSine
                    from: 0.5
                    to: 0
                    duration: 3000
                }
            }

            NumberAnimation {
                target: valueSource
                property: "rpm"
                easing.type: Easing.InOutSine
                to: 6.5
                duration: 600
            }

            // Second to first gear.
            ParallelAnimation {
                NumberAnimation {
                    target: valueSource
                    property: "kph"
                    easing.type: Easing.InOutSine
                    to: 0
                    duration: 5000
                }
                NumberAnimation {
                    target: valueSource
                    property: "rpm"
                    easing.type: Easing.InOutSine
                    to: 1
                    duration: 4500
                }
                NumberAnimation {
                    target: valueSource
                    property: "fuel"
                    easing.type: Easing.InOutSine
                    from: 0.75
                    to: 1
                    duration: 3000
                }
                NumberAnimation {
                    target: valueSource
                    property: "oil"
                    easing.type: Easing.InOutSine
                    from: 0.5
                    to: 0
                    duration: 5000
                }
            }

            PauseAnimation {
                duration: 1000
            }
        }
    }
}
