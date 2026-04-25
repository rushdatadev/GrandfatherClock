import QtQuick
import QtMultimedia

Item {
    id: engine

    property real volume: 0.7
    property string chimeInterval: "hourly"
    property bool bellCount: true
    property string hourChime: "Grandfather"
    property string quarterChimeSet: "Westminister"

    readonly property url soundsDir: Qt.resolvedUrl("../sounds/")

    property var queue: []
    property bool _busy: false

    AudioOutput {
        id: audioOut
        volume: engine.volume
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
    }

    function _resolve(name) {
        return soundsDir + name + ".wav"
    }

    function playNext() {
        if (queue.length === 0) {
            _busy = false
            return
        }
        if (_busy) {
            // Already playing; EndOfMedia will re-call us.
            return
        }
        const next = queue.shift()
        _busy = true
        console.log("[GFC] playNext source=" + next + "  vol=" + audioOut.volume + "  qlen-after-shift=" + queue.length)
        player.source = next
        player.play()
    }

    function _enqueue(name) {
        const url = _resolve(name)
        queue.push(url)
        console.log("[GFC] enqueue " + name + "  busy=" + _busy + "  qlen=" + queue.length)
        if (!_busy) {
            playNext()
        }
    }

    function previewHourly(hour) {
        console.log("[GFC] previewHourly(" + hour + ")  interval=" + chimeInterval + "  bellCount=" + bellCount + "  hourChime=" + hourChime)
        if (chimeInterval === "quarterly") {
            _enqueue(quarterChimeSet + "4")
        }
        const tolls = bellCount ? ((hour % 12) || 12) : 1
        for (let i = 0; i < tolls; i++) {
            _enqueue(hourChime)
        }
    }

    function previewQuarter(which) {
        console.log("[GFC] previewQuarter(" + which + ")  set=" + quarterChimeSet)
        _enqueue(quarterChimeSet + which)
    }

    function tick(now) {
        const hour = now.getHours()
        const minute = now.getMinutes()
        const second = now.getSeconds()

        if (second !== 0) return
        if (minute === lastChimedMinute) return
        lastChimedMinute = minute

        if (minute === 0) {
            if (chimeInterval === "quarterly") {
                _enqueue(quarterChimeSet + "4")
            }
            const tolls = bellCount ? ((hour % 12) || 12) : 1
            for (let i = 0; i < tolls; i++) {
                _enqueue(hourChime)
            }
        } else if (minute === 30 && (chimeInterval === "half" || chimeInterval === "quarterly")) {
            _enqueue(quarterChimeSet + "2")
        } else if (minute === 15 && chimeInterval === "quarterly") {
            _enqueue(quarterChimeSet + "1")
        } else if (minute === 45 && chimeInterval === "quarterly") {
            _enqueue(quarterChimeSet + "3")
        }
    }

    property int lastChimedMinute: -1
}
