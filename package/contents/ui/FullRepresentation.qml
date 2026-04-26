import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami
import org.kde.plasma.plasmoid
import org.kde.plasma.components as PlasmaComponents

ColumnLayout {
    id: root

    property date currentTime: new Date()
    property var engine

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
        variant: Plasmoid.configuration.clockFace
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
            id: popupVolumeSlider
            Layout.fillWidth: true
            from: 0
            to: 100
            stepSize: 5
            enabled: !Plasmoid.configuration.muted

            Component.onCompleted: value = Plasmoid.configuration.volume

            Connections {
                target: Plasmoid.configuration
                function onVolumeChanged() {
                    if (!popupVolumeSlider.pressed && !popupVolumeSlider.activeFocus) {
                        popupVolumeSlider.value = Plasmoid.configuration.volume
                    }
                }
            }

            // Two roles:
            //  - When the user is interacting (pressed or activeFocus),
            //    push their value into the config.
            //  - Otherwise, Plasma's popup re-render (positioning frame,
            //    expand/collapse) sometimes silently resets value to 0.
            //    Any divergence from config in this state is spurious,
            //    so snap back. The reassignment refires this handler
            //    once but the second pass is a no-op (value === config).
            onValueChanged: {
                if (pressed || activeFocus) {
                    if (value !== Plasmoid.configuration.volume) {
                        Plasmoid.configuration.volume = value
                    }
                } else if (value !== Plasmoid.configuration.volume) {
                    value = Plasmoid.configuration.volume
                }
            }
        }

        PlasmaComponents.Label {
            text: Plasmoid.configuration.volume + "%"
            Layout.preferredWidth: Kirigami.Units.gridUnit * 2.5
            horizontalAlignment: Text.AlignRight
        }
    }

    RowLayout {
        Layout.alignment: Qt.AlignHCenter
        spacing: Kirigami.Units.smallSpacing

        QQC2.Button {
            text: i18n("Test Hour")
            onClicked: root.engine.previewHourly(root.currentTime.getHours())
        }
        QQC2.Button {
            text: i18n("Test Quarter")
            onClicked: root.engine.previewQuarter(1)
        }
    }
}
