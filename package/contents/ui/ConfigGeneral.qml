import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    id: page

    // Settings owned by this page
    property string cfg_chimeInterval: "hourly"
    property string cfg_chimeIntervalDefault: "hourly"
    property bool cfg_bellCount: true
    property bool cfg_bellCountDefault: true
    property int cfg_volume: 25
    property int cfg_volumeDefault: 25
    property bool cfg_muted: false
    property bool cfg_mutedDefault: false
    property bool cfg_quietHoursEnabled: false
    property bool cfg_quietHoursEnabledDefault: false
    property int cfg_quietStartHour: 22
    property int cfg_quietStartHourDefault: 22
    property int cfg_quietStartMinute: 0
    property int cfg_quietStartMinuteDefault: 0
    property int cfg_quietEndHour: 7
    property int cfg_quietEndHourDefault: 7
    property int cfg_quietEndMinute: 0
    property int cfg_quietEndMinuteDefault: 0
    property int cfg_fadeDurationMs: 80
    property int cfg_fadeDurationMsDefault: 80

    // Cross-page stubs
    property string cfg_hourChime: "BigBenHourBell"
    property string cfg_hourChimeDefault: "BigBenHourBell"
    property string cfg_quarterChimeSet: "BigBenWestminster"
    property string cfg_quarterChimeSetDefault: "BigBenWestminster"
    property string cfg_clockFace: "07-wood-brass"
    property string cfg_clockFaceDefault: "07-wood-brass"
    property bool cfg_showSeconds: true
    property bool cfg_showSecondsDefault: true

    Kirigami.FormLayout {
        QQC2.ComboBox {
            id: intervalCombo
            Kirigami.FormData.label: i18n("Chime interval:")
            textRole: "label"
            valueRole: "value"
            model: [
                { label: i18n("Hourly"), value: "hourly" },
                { label: i18n("Half-hourly"), value: "half" },
                { label: i18n("Quarterly (Westminster)"), value: "quarterly" }
            ]
            currentIndex: model.findIndex(m => m.value === page.cfg_chimeInterval)
            onActivated: page.cfg_chimeInterval = model[currentIndex].value
        }

        QQC2.CheckBox {
            Kirigami.FormData.label: i18n("Bell count:")
            text: i18n("Toll the bell once per hour number (e.g. 3 tolls at 3 o'clock)")
            checked: page.cfg_bellCount
            onToggled: page.cfg_bellCount = checked
        }

        QQC2.Slider {
            id: volumeSlider
            Kirigami.FormData.label: i18n("Volume:")
            from: 0
            to: 100
            stepSize: 5
            Layout.preferredWidth: Kirigami.Units.gridUnit * 14
            value: page.cfg_volume
            onMoved: page.cfg_volume = value
        }

        QQC2.Label {
            text: page.cfg_volume + "%"
        }

        QQC2.CheckBox {
            Kirigami.FormData.label: i18n("Mute:")
            text: i18n("Silence all chimes")
            checked: page.cfg_muted
            onToggled: page.cfg_muted = checked
        }

        Item {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Quiet hours")
        }

        QQC2.CheckBox {
            id: quietEnableCheck
            Kirigami.FormData.label: i18n("Enabled:")
            text: i18n("Skip chimes during the time window below")
            checked: page.cfg_quietHoursEnabled
            onToggled: page.cfg_quietHoursEnabled = checked
        }

        RowLayout {
            Kirigami.FormData.label: i18n("From:")
            enabled: page.cfg_quietHoursEnabled
            QQC2.SpinBox {
                id: startHour12
                from: 1
                to: 12
                value: ((page.cfg_quietStartHour + 11) % 12) + 1
                onValueModified: {
                    const isPM = page.cfg_quietStartHour >= 12
                    page.cfg_quietStartHour = (value % 12) + (isPM ? 12 : 0)
                }
            }
            QQC2.Label { text: ":" }
            QQC2.SpinBox {
                from: 0
                to: 59
                stepSize: 5
                value: page.cfg_quietStartMinute
                onValueModified: page.cfg_quietStartMinute = value
                textFromValue: function(v) { return v.toString().padStart(2, "0") }
            }
            QQC2.ComboBox {
                id: startMeridiem
                Layout.preferredWidth: Kirigami.Units.gridUnit * 4
                model: ["AM", "PM"]
                currentIndex: page.cfg_quietStartHour < 12 ? 0 : 1
                onActivated: {
                    const h12 = startHour12.value
                    const isPM = currentIndex === 1
                    page.cfg_quietStartHour = (h12 % 12) + (isPM ? 12 : 0)
                }
            }
        }

        RowLayout {
            Kirigami.FormData.label: i18n("To:")
            enabled: page.cfg_quietHoursEnabled
            QQC2.SpinBox {
                id: endHour12
                from: 1
                to: 12
                value: ((page.cfg_quietEndHour + 11) % 12) + 1
                onValueModified: {
                    const isPM = page.cfg_quietEndHour >= 12
                    page.cfg_quietEndHour = (value % 12) + (isPM ? 12 : 0)
                }
            }
            QQC2.Label { text: ":" }
            QQC2.SpinBox {
                from: 0
                to: 59
                stepSize: 5
                value: page.cfg_quietEndMinute
                onValueModified: page.cfg_quietEndMinute = value
                textFromValue: function(v) { return v.toString().padStart(2, "0") }
            }
            QQC2.ComboBox {
                id: endMeridiem
                Layout.preferredWidth: Kirigami.Units.gridUnit * 4
                model: ["AM", "PM"]
                currentIndex: page.cfg_quietEndHour < 12 ? 0 : 1
                onActivated: {
                    const h12 = endHour12.value
                    const isPM = currentIndex === 1
                    page.cfg_quietEndHour = (h12 % 12) + (isPM ? 12 : 0)
                }
            }
        }

        QQC2.Label {
            function fmt12(h, m) {
                const h12 = ((h + 11) % 12) + 1
                const mm = String(m).padStart(2, "0")
                const ampm = h < 12 ? "AM" : "PM"
                return h12 + ":" + mm + " " + ampm
            }
            visible: page.cfg_quietHoursEnabled
            text: {
                const start = fmt12(page.cfg_quietStartHour, page.cfg_quietStartMinute)
                const end = fmt12(page.cfg_quietEndHour, page.cfg_quietEndMinute)
                const startMin = page.cfg_quietStartHour * 60 + page.cfg_quietStartMinute
                const endMin = page.cfg_quietEndHour * 60 + page.cfg_quietEndMinute
                if (startMin === endMin) return i18n("(start and end are equal — quiet hours effectively off)")
                if (startMin < endMin) return i18nc("@info quiet hours window", "Silent %1 → %2 each day", start, end)
                return i18nc("@info quiet hours window crossing midnight", "Silent %1 → %2 (crosses midnight)", start, end)
            }
            font.italic: true
            color: Kirigami.Theme.disabledTextColor
        }

        Item {
            Kirigami.FormData.isSection: true
            Kirigami.FormData.label: i18n("Tone shaping")
        }

        QQC2.Slider {
            id: fadeSlider
            Kirigami.FormData.label: i18n("Fade in/out:")
            from: 0
            to: 500
            stepSize: 10
            Layout.preferredWidth: Kirigami.Units.gridUnit * 14
            value: page.cfg_fadeDurationMs
            onMoved: page.cfg_fadeDurationMs = value
        }

        QQC2.Label {
            text: page.cfg_fadeDurationMs === 0
                ? i18n("disabled")
                : page.cfg_fadeDurationMs + " ms"
        }
    }
}
