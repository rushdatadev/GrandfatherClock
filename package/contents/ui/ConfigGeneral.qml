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
    property int cfg_volume: 70
    property int cfg_volumeDefault: 70
    property bool cfg_muted: false
    property bool cfg_mutedDefault: false

    // Cross-page stubs — Plasma's KConfigXT pushes every kcfg entry
    // onto every page; declaring stubs silences "page does not have
    // property cfg_X" warnings without binding UI here.
    property string cfg_hourChime: "Grandfather"
    property string cfg_hourChimeDefault: "Grandfather"
    property string cfg_quarterChimeSet: "Westminister"
    property string cfg_quarterChimeSetDefault: "Westminister"
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
    }
}
