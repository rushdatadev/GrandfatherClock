import QtQuick
import org.kde.kirigami as Kirigami

Item {
    id: face

    property date currentTime: new Date()
    property bool showSeconds: true

    implicitWidth: Kirigami.Units.gridUnit * 8
    implicitHeight: Kirigami.Units.gridUnit * 8

    Canvas {
        id: faceCanvas
        anchors.fill: parent
        antialiasing: true

        onPaint: {
            const ctx = getContext("2d")
            const w = width, h = height
            const cx = w / 2, cy = h / 2
            const r = Math.min(w, h) / 2 - 4

            ctx.reset()
            ctx.lineCap = "round"

            // Face
            ctx.beginPath()
            ctx.fillStyle = Kirigami.Theme.backgroundColor
            ctx.arc(cx, cy, r, 0, 2 * Math.PI)
            ctx.fill()
            ctx.lineWidth = 2
            ctx.strokeStyle = Kirigami.Theme.textColor
            ctx.stroke()

            // Hour ticks
            for (let i = 0; i < 12; i++) {
                const a = i * Math.PI / 6
                const x1 = cx + Math.sin(a) * (r - 8)
                const y1 = cy - Math.cos(a) * (r - 8)
                const x2 = cx + Math.sin(a) * r
                const y2 = cy - Math.cos(a) * r
                ctx.beginPath()
                ctx.lineWidth = 2
                ctx.moveTo(x1, y1)
                ctx.lineTo(x2, y2)
                ctx.stroke()
            }
        }

        Connections {
            target: Kirigami.Theme
            function onColorsChanged() { faceCanvas.requestPaint() }
        }
    }

    // Hour hand
    Rectangle {
        property real angle: ((face.currentTime.getHours() % 12) + face.currentTime.getMinutes() / 60) * 30
        width: 4
        height: Math.min(face.width, face.height) * 0.28
        color: Kirigami.Theme.textColor
        radius: 2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter
        anchors.bottomMargin: -4
        transformOrigin: Item.Bottom
        rotation: angle
    }

    // Minute hand
    Rectangle {
        property real angle: face.currentTime.getMinutes() * 6 + face.currentTime.getSeconds() / 10
        width: 3
        height: Math.min(face.width, face.height) * 0.40
        color: Kirigami.Theme.textColor
        radius: 1
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter
        anchors.bottomMargin: -3
        transformOrigin: Item.Bottom
        rotation: angle
    }

    // Second hand
    Rectangle {
        visible: face.showSeconds
        property real angle: face.currentTime.getSeconds() * 6
        width: 1
        height: Math.min(face.width, face.height) * 0.44
        color: Kirigami.Theme.highlightColor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter
        anchors.bottomMargin: -1
        transformOrigin: Item.Bottom
        rotation: angle
    }

    // Center cap
    Rectangle {
        width: 8; height: 8; radius: 4
        color: Kirigami.Theme.textColor
        anchors.centerIn: parent
    }
}
