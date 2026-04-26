import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    id: page

    // Settings owned by this page
    property string cfg_hourChime: "Grandfather"
    property string cfg_hourChimeDefault: "Grandfather"
    property string cfg_quarterChimeSet: "Westminister"
    property string cfg_quarterChimeSetDefault: "Westminister"

    // Cross-page stubs
    property string cfg_chimeInterval: "hourly"
    property string cfg_chimeIntervalDefault: "hourly"
    property bool cfg_bellCount: true
    property bool cfg_bellCountDefault: true
    property int cfg_volume: 70
    property int cfg_volumeDefault: 70
    property bool cfg_muted: false
    property bool cfg_mutedDefault: false
    property string cfg_clockFace: "07-wood-brass"
    property string cfg_clockFaceDefault: "07-wood-brass"
    property bool cfg_showSeconds: true
    property bool cfg_showSecondsDefault: true

    Kirigami.FormLayout {
        QQC2.ComboBox {
            id: hourCombo
            Kirigami.FormData.label: i18n("Hourly toll:")
            textRole: "label"
            valueRole: "value"
            model: [
                { label: i18n("Grandfather"), value: "Grandfather" },
                { label: i18n("Tower"), value: "Tower" },
                { label: i18n("Cuckoo"), value: "Cuckoo" }
            ]
            currentIndex: model.findIndex(m => m.value === page.cfg_hourChime)
            onActivated: page.cfg_hourChime = model[currentIndex].value
        }

        QQC2.ComboBox {
            id: quarterCombo
            Kirigami.FormData.label: i18n("Quarter chimes:")
            textRole: "label"
            valueRole: "value"
            model: [
                { label: i18n("Westminster"), value: "Westminister" },
                { label: i18n("Close Encounters of the Third Kind"), value: "CloseEncountersOfTheThirdKind" }
            ]
            currentIndex: model.findIndex(m => m.value === page.cfg_quarterChimeSet)
            onActivated: page.cfg_quarterChimeSet = model[currentIndex].value
        }

        QQC2.Label {
            Kirigami.FormData.label: i18n("Note:")
            text: i18n("The 'Westminister' value preserves the original spelling used in the upstream audio file names.")
            wrapMode: Text.Wrap
            Layout.preferredWidth: Kirigami.Units.gridUnit * 20
        }
    }
}
