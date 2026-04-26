import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid

Item {
    id: root

    property date currentTime: new Date()

    Layout.preferredWidth: Kirigami.Units.gridUnit * 16
    Layout.preferredHeight: Kirigami.Units.gridUnit * 16

    ClockFace {
        id: face
        anchors.fill: parent
        currentTime: root.currentTime
        showSeconds: Plasmoid.configuration.showSeconds
        variant: Plasmoid.configuration.clockFace
    }

    MouseArea {
        id: clickArea
        anchors.fill: face
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onClicked: Plasmoid.configuration.muted = !Plasmoid.configuration.muted

        QQC2.ToolTip.visible: containsMouse
        QQC2.ToolTip.text: Plasmoid.configuration.muted
            ? i18n("Click to unmute")
            : i18n("Click to mute")
        QQC2.ToolTip.delay: 800
    }

    // Red mute overlay, centered on the clock face. isMask + color
    // recolors the themed icon glyph so it reads as red regardless
    // of the user's icon theme.
    Kirigami.Icon {
        id: muteOverlay
        anchors.centerIn: parent
        width: Math.min(parent.width, parent.height) * 0.4
        height: width
        source: "audio-volume-muted"
        color: "red"
        isMask: true
        visible: Plasmoid.configuration.muted
        opacity: 0.9
    }
}
