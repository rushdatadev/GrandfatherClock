import QtQuick
import org.kde.kirigami as Kirigami

Item {
    id: face

    property date currentTime: new Date()
    property bool showSeconds: true
    property string variant: "07-wood-brass"

    implicitWidth: Kirigami.Units.gridUnit * 8
    implicitHeight: Kirigami.Units.gridUnit * 8

    readonly property url variantDir: Qt.resolvedUrl("../clocks/" + variant + "/")
    readonly property real hourAngle:
        ((currentTime.getHours() % 12) + currentTime.getMinutes() / 60 + currentTime.getSeconds() / 3600) * 30
    readonly property real minuteAngle:
        (currentTime.getMinutes() + currentTime.getSeconds() / 60) * 6
    readonly property real secondAngle:
        currentTime.getSeconds() * 6

    Image {
        anchors.fill: parent
        source: face.variantDir + "dial.svg"
        sourceSize.width: face.width
        sourceSize.height: face.height
        smooth: true
        antialiasing: true
        fillMode: Image.PreserveAspectFit
        asynchronous: true
    }

    Image {
        anchors.fill: parent
        source: face.variantDir + "hour.svg"
        sourceSize.width: face.width
        sourceSize.height: face.height
        smooth: true
        antialiasing: true
        fillMode: Image.PreserveAspectFit
        asynchronous: true
        rotation: face.hourAngle
    }

    Image {
        anchors.fill: parent
        source: face.variantDir + "minute.svg"
        sourceSize.width: face.width
        sourceSize.height: face.height
        smooth: true
        antialiasing: true
        fillMode: Image.PreserveAspectFit
        asynchronous: true
        rotation: face.minuteAngle
    }

    Image {
        visible: face.showSeconds
        anchors.fill: parent
        source: face.variantDir + "second.svg"
        sourceSize.width: face.width
        sourceSize.height: face.height
        smooth: true
        antialiasing: true
        fillMode: Image.PreserveAspectFit
        asynchronous: true
        rotation: face.secondAngle
    }
}
