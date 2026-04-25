import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents

ColumnLayout {
    id: root

    property date currentTime: new Date()
    property var chimeEngine

    Layout.preferredWidth: Kirigami.Units.gridUnit * 18
    Layout.preferredHeight: Kirigami.Units.gridUnit * 22
    spacing: Kirigami.Units.largeSpacing

    PlasmaComponents.Label {
        Layout.alignment: Qt.AlignHCenter
        text: Qt.formatTime(root.currentTime, "h:mm:ss AP")
        font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.4
    }

    ClockFace {
        Layout.alignment: Qt.AlignHCenter
        Layout.preferredWidth: Kirigami.Units.gridUnit * 14
        Layout.preferredHeight: Kirigami.Units.gridUnit * 14
        currentTime: root.currentTime
        showSeconds: Plasmoid.configuration.showSeconds
    }

    RowLayout {
        Layout.fillWidth: true
        spacing: Kirigami.Units.smallSpacing

        QQC2.ToolButton {
            icon.name: Plasmoid.configuration.muted ? "audio-volume-muted" : "audio-volume-high"
            onClicked: Plasmoid.configuration.muted = !Plasmoid.configuration.muted
            QQC2.ToolTip.visible: hovered
            QQC2.ToolTip.text: Plasmoid.configuration.muted ? i18n("Unmute") : i18n("Mute")
        }

        QQC2.Slider {
            Layout.fillWidth: true
            from: 0.0
            to: 1.0
            value: Plasmoid.configuration.volume
            enabled: !Plasmoid.configuration.muted
            onMoved: Plasmoid.configuration.volume = value
        }

        PlasmaComponents.Label {
            text: Math.round(Plasmoid.configuration.volume * 100) + "%"
            Layout.preferredWidth: Kirigami.Units.gridUnit * 2.5
            horizontalAlignment: Text.AlignRight
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        spacing: Kirigami.Units.smallSpacing

        QQC2.Button {
            text: i18n("Test Hour")
            onClicked: root.chimeEngine.previewHourly(root.currentTime.getHours())
        }
        QQC2.Button {
            text: i18n("Test Quarter")
            onClicked: root.chimeEngine.previewQuarter(1)
        }
    }
}
