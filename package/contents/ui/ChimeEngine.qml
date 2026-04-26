import QtQuick
import QtMultimedia
import Qt.labs.folderlistmodel

Item {
    id: engine

    property real volume: 0.25
    property string chimeInterval: "hourly"
    property bool bellCount: true
    property string hourChime: "BigBenHourBell"
    property string quarterChimeSet: "BigBenWestminster"

    // Quiet hours — only consulted by tick(); previewHourly() and
    // previewQuarter() bypass them so the config Preview buttons
    // always play.
    property bool quietHoursEnabled: false
    property int quietStartHour: 22
    property int quietStartMinute: 0
    property int quietEndHour: 7
    property int quietEndMinute: 0

    // Per-toll fade in/out. Set to 0 to disable.
    property int fadeDurationMs: 80
    property real envelope: 1.0

    readonly property url bellsDir: Qt.resolvedUrl("../sounds/bells/")
    readonly property url chimesDir: Qt.resolvedUrl("../sounds/chimes/")

    // Populated at startup from FolderListModels below. Maps base
    // file name (without extension) to the full file URL, so callers
    // can reference a sound by `Grandfather` or `BigBenHourBell` and
    // not care whether it's .wav, .ogg, .flac, etc.
    property var bellRegistry: ({})
    property var chimeRegistry: ({})

    property var queue: []
    property bool _busy: false
    property int lastChimedMinute: -1

    FolderListModel {
        id: bellsModel
        folder: engine.bellsDir
        nameFilters: ["*.wav", "*.ogg", "*.flac", "*.mp3", "*.opus"]
        showDirs: false
        onStatusChanged: if (status === FolderListModel.Ready) {
            const reg = {}
            for (let i = 0; i < count; i++) {
                const fname = get(i, "fileName")
                const dot = fname.lastIndexOf(".")
                const base = dot >= 0 ? fname.substring(0, dot) : fname
                reg[base] = engine.bellsDir + fname
            }
            engine.bellRegistry = reg
        }
    }

    FolderListModel {
        id: chimesModel
        folder: engine.chimesDir
        nameFilters: ["*.wav", "*.ogg", "*.flac", "*.mp3", "*.opus"]
        showDirs: false
        onStatusChanged: if (status === FolderListModel.Ready) {
            const reg = {}
            for (let i = 0; i < count; i++) {
                const fname = get(i, "fileName")
                const dot = fname.lastIndexOf(".")
                const base = dot >= 0 ? fname.substring(0, dot) : fname
                reg[base] = engine.chimesDir + fname
            }
            engine.chimeRegistry = reg
        }
    }

    AudioOutput {
        id: audioOut
        volume: engine.volume * engine.envelope
    }

    MediaPlayer {
        id: player
        audioOutput: audioOut
        onMediaStatusChanged: {
            if (mediaStatus === MediaPlayer.EndOfMedia) {
                engine._busy = false
                engine.playNext()
            } else if (mediaStatus === MediaPlayer.InvalidMedia) {
                console.warn("[GFC] InvalidMedia for " + source)
                engine._busy = false
                engine.playNext()
            }
        }
        onErrorOccurred: (err, str) => {
            console.warn("[GFC] MediaPlayer error " + err + ": " + str + "  source=" + source)
            engine._busy = false
            engine.playNext()
        }
        onPositionChanged: {
            if (engine.fadeDurationMs > 0
                && duration > 0
                && !fadeOutAnim.running
                && engine.envelope > 0.5
                && (duration - position) <= engine.fadeDurationMs) {
                fadeOutAnim.start()
            }
        }
    }

    NumberAnimation {
        id: fadeInAnim
        target: engine
        property: "envelope"
        from: 0
        to: 1
        duration: engine.fadeDurationMs
    }

    NumberAnimation {
        id: fadeOutAnim
        target: engine
        property: "envelope"
        from: 1
        to: 0
        duration: engine.fadeDurationMs
    }

    function _resolve(name, kind) {
        const reg = (kind === "bell") ? bellRegistry : chimeRegistry
        const url = reg[name]
        if (!url) {
            console.warn("[GFC] " + kind + " sound not found: " + name + "  registry=" + JSON.stringify(Object.keys(reg)))
            return ""
        }
        return url
    }

    function playNext() {
        if (queue.length === 0) {
            _busy = false
            return
        }
        if (_busy) {
            return
        }
        const next = queue.shift()
        if (!next) {
            // resolution failed; skip and continue
            playNext()
            return
        }
        _busy = true
        fadeOutAnim.stop()
        if (fadeDurationMs > 0) {
            envelope = 0
            fadeInAnim.start()
        } else {
            envelope = 1
        }
        player.source = next
        player.play()
    }

    function _enqueue(name, kind) {
        const url = _resolve(name, kind)
        if (!url) return  // skip missing sounds rather than queueing empty
        queue.push(url)
        if (!_busy) {
            playNext()
        }
    }

    function _isQuietHour(hour, minute) {
        if (!quietHoursEnabled) return false
        const cur = hour * 60 + minute
        const start = quietStartHour * 60 + quietStartMinute
        const end = quietEndHour * 60 + quietEndMinute
        if (start === end) return false
        if (start < end) return cur >= start && cur < end
        return cur >= start || cur < end
    }

    function previewHourly(hour) {
        if (chimeInterval === "quarterly") {
            _enqueue(quarterChimeSet + "4", "chime")
        }
        const tolls = bellCount ? ((hour % 12) || 12) : 1
        for (let i = 0; i < tolls; i++) {
            _enqueue(hourChime, "bell")
        }
    }

    function previewQuarter(which) {
        _enqueue(quarterChimeSet + which, "chime")
    }

    function tick(now) {
        const hour = now.getHours()
        const minute = now.getMinutes()
        const second = now.getSeconds()

        if (second !== 0) return
        if (minute === lastChimedMinute) return
        lastChimedMinute = minute

        if (_isQuietHour(hour, minute)) return

        if (minute === 0) {
            if (chimeInterval === "quarterly") {
                _enqueue(quarterChimeSet + "4", "chime")
            }
            const tolls = bellCount ? ((hour % 12) || 12) : 1
            for (let i = 0; i < tolls; i++) {
                _enqueue(hourChime, "bell")
            }
        } else if (minute === 30 && (chimeInterval === "half" || chimeInterval === "quarterly")) {
            _enqueue(quarterChimeSet + "2", "chime")
        } else if (minute === 15 && chimeInterval === "quarterly") {
            _enqueue(quarterChimeSet + "1", "chime")
        } else if (minute === 45 && chimeInterval === "quarterly") {
            _enqueue(quarterChimeSet + "3", "chime")
        }
    }
}
