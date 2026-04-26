import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    id: page

    // Settings owned by this page
    property string cfg_hourChime: "BigBenHourBell"
    property string cfg_hourChimeDefault: "BigBenHourBell"
    property string cfg_quarterChimeSet: "BigBenWestminster"
    property string cfg_quarterChimeSetDefault: "BigBenWestminster"

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
    property string cfg_clockFace: "07-wood-brass"
    property string cfg_clockFaceDefault: "07-wood-brass"
    property bool cfg_showSeconds: true
    property bool cfg_showSecondsDefault: true

    // Self-contained engine for live previews. Bound to live cfg_*
    // values so the user hears their pending selection, not what's
    // currently on disk. previewHourly/previewQuarter bypass quiet
    // hours by design (those checks live in tick(), not the preview
    // entry points).
    ChimeEngine {
        id: previewEngine
        volume: page.cfg_muted ? 0 : (page.cfg_volume / 100)
        chimeInterval: page.cfg_chimeInterval
        bellCount: page.cfg_bellCount
        hourChime: page.cfg_hourChime
        quarterChimeSet: page.cfg_quarterChimeSet
        fadeDurationMs: page.cfg_fadeDurationMs
    }

    Kirigami.FormLayout {
        RowLayout {
            Kirigami.FormData.label: i18n("Hourly toll:")
            QQC2.ComboBox {
                id: hourCombo
                textRole: "label"
                valueRole: "value"
                model: [
                    { label: i18n("Grandfather"), value: "Grandfather" },
                    { label: i18n("Tower"), value: "Tower" },
                    { label: i18n("Cuckoo"), value: "Cuckoo" },
                    { label: i18n("Big Ben"), value: "BigBenHourBell" }
                ]
                currentIndex: model.findIndex(m => m.value === page.cfg_hourChime)
                onActivated: page.cfg_hourChime = model[currentIndex].value
            }
            QQC2.Button {
                text: i18n("Preview")
                icon.name: "media-playback-start"
                onClicked: previewEngine._enqueue(page.cfg_hourChime, "bell")
            }
        }

        RowLayout {
            Kirigami.FormData.label: i18n("Quarter chimes:")
            QQC2.ComboBox {
                id: quarterCombo
                textRole: "label"
                valueRole: "value"
                model: [
                    { label: i18n("Westminster (vintage)"), value: "Westminister" },
                    { label: i18n("Big Ben Westminster"), value: "BigBenWestminster" },
                    { label: i18n("Close Encounters of the Third Kind"), value: "CloseEncountersOfTheThirdKind" }
                ]
                currentIndex: model.findIndex(m => m.value === page.cfg_quarterChimeSet)
                onActivated: page.cfg_quarterChimeSet = model[currentIndex].value
            }
            Repeater {
                model: 4
                QQC2.Button {
                    text: "Q" + (modelData + 1)
                    icon.name: "media-playback-start"
                    onClicked: previewEngine.previewQuarter(modelData + 1)
                }
            }
        }
    }
}
