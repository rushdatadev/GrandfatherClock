import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    id: page

    property alias cfg_hourChime: hourCombo.currentValue
    property alias cfg_quarterChimeSet: quarterCombo.currentValue

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
            Component.onCompleted: {
                for (let i = 0; i < model.length; i++) {
                    if (model[i].value === cfg_hourChime) {
                        currentIndex = i
                        break
                    }
                }
            }
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
            Component.onCompleted: {
                for (let i = 0; i < model.length; i++) {
                    if (model[i].value === cfg_quarterChimeSet) {
                        currentIndex = i
                        break
                    }
                }
            }
        }

        QQC2.Label {
            Kirigami.FormData.label: i18n("Note:")
            text: i18n("The 'Westminister' value preserves the original spelling used in the upstream audio file names.")
            wrapMode: Text.Wrap
            Layout.preferredWidth: Kirigami.Units.gridUnit * 20
        }
    }
}
