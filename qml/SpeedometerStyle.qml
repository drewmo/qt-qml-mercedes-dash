import QtQuick 2.2
import QtQuick.Controls.Styles 1.4

Item {
    id: speedometerBackgroundStyle
    property string icon: ""
    property int value: 0
    property int needleXoffset: 100
    property int bigNeedleMinX: -150
    property int bigNeedleMaxX: 480

    function mapValues(value, in_min, in_max, out_min, out_max) {
        return (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
     }

    function toPixels(percentage) {
        return percentage * container.width / 5;
    }

    Rectangle {
        id: speedometerBackground
        width: 40
        height: 708
        x: parent.width / 2 - width / 2
        y: (parent.height / 2 - height / 2) + 25

        Image {
            source: "qrc:/images/speedometer_background.png"
            fillMode: Image.PreserveAspectFit

        }
    }

    Rectangle {
        id: speedometerNeedle
        width: 769
        height: 889
        y: parent.height / 2 - height / 2
        x: mapValues(value, 120, 0, bigNeedleMinX, bigNeedleMaxX)
        color: "transparent"

        Image {
            source: "qrc:/images/big_needle.png"
            fillMode: Image.PreserveAspectFit
        }

    }

    Rectangle {
        id: mainGaugeBackground
        width: 769
        height: 1026
        x: parent.width / 2 - width / 2
        y: parent.height / 2 - height / 2
        color: "transparent"

        Image {
            source: "qrc:/images/gauge_background.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    Rectangle {
        id: speedTextDisplay
        x: parent.width / 2
        y: -120

        Text {
            id: speedText
            font.pixelSize: toPixels(0.3)
            text: kphInt
            color: "white"
            horizontalAlignment: Text.AlignRight
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            anchors.topMargin: toPixels(0.1)

            readonly property int kphInt: value
        }
        Text {
            text: "mph"
            color: "white"
            font.pixelSize: toPixels(0.09)
            anchors.top: speedText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
