import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    id: page

    // Settings owned by this page
    property string cfg_clockFace: "07-wood-brass"
    property string cfg_clockFaceDefault: "07-wood-brass"
    property bool cfg_showSeconds: true
    property bool cfg_showSecondsDefault: true

    // Cross-page stubs
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
    property string cfg_hourChime: "BigBenHourBell"
    property string cfg_hourChimeDefault: "BigBenHourBell"
    property string cfg_quarterChimeSet: "BigBenWestminster"
    property string cfg_quarterChimeSetDefault: "BigBenWestminster"

    Kirigami.FormLayout {
        QQC2.ComboBox {
            id: faceCombo
            Kirigami.FormData.label: i18n("Clock face:")
            textRole: "label"
            valueRole: "value"
            model: [
                { label: i18n("Big Ben — pre-restoration"),  value: "01-bigben-pre" },
                { label: i18n("Big Ben — post-restoration"), value: "02-bigben-post" },
                { label: i18n("Victorian ornate"),           value: "03-victorian" },
                { label: i18n("Minimal modern"),             value: "04-minimal" },
                { label: i18n("Art Deco"),                   value: "05-artdeco" },
                { label: i18n("Brutalist"),                  value: "06-brutalist" },
                { label: i18n("Skeuomorphic wood + brass"),  value: "07-wood-brass" },
                { label: i18n("Flat geometric"),             value: "08-flat" }
            ]
            currentIndex: model.findIndex(m => m.value === page.cfg_clockFace)
            onActivated: page.cfg_clockFace = model[currentIndex].value
        }

        QQC2.CheckBox {
            Kirigami.FormData.label: i18n("Second hand:")
            text: i18n("Show the second hand")
            checked: page.cfg_showSeconds
            onToggled: page.cfg_showSeconds = checked
        }

        ClockFace {
            Kirigami.FormData.label: i18n("Preview:")
            Layout.preferredWidth: Kirigami.Units.gridUnit * 12
            Layout.preferredHeight: Kirigami.Units.gridUnit * 12
            variant: faceCombo.currentValue
            showSeconds: page.cfg_showSeconds
            currentTime: previewClock.now

            Timer {
                id: previewClock
                property date now: new Date()
                interval: 1000
                running: true
                repeat: true
                triggeredOnStart: true
                onTriggered: now = new Date()
            }
        }
    }
}
