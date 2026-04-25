# Audio architecture

## Current state (v0.1)

Pre-rendered audio shipped in the package:

- 11 WAV files at `package/contents/sounds/*.wav`
- 22050 Hz, 16-bit signed PCM, mono
- Total ~4.8 MB
- Sourced from upstream `grandfatherclock 1.0.3`'s `.au` files
  (8-bit µ-law @ 8 kHz, telephone-grade) — converted in place by
  `ffmpeg -ar 22050 -ac 1 -c:a pcm_s16le`. No fidelity gain over the
  source, just format compatibility with `QtMultimedia`'s `MediaPlayer`
  / `SoundEffect` and a consistent sample rate.
- Engine: `MediaPlayer` + `AudioOutput` in `ChimeEngine.qml`,
  consuming a flat queue of file URLs.

This works but inherits the upstream's quality limit: chimes will never
sound better than 8 kHz µ-law at the source.

## Planned upgrade: on-demand FluidSynth rendering

### Goal

Render BHI-style chime sequences (and more) at high fidelity, with the
chime tune and the bell timbre as **independently selectable axes** —
so the user can pair *any chime* with *any bell sound*, including
user-supplied SoundFonts.

### Architecture

1. **Ship MIDI sequences**: tiny `.mid` files (~500 B–1.5 KB each) for
   each chime tune. Either BHI's set (subject to permission) or
   re-derived/composed sequences.
2. **Ship one or two default SoundFonts (`.sf2`)**: a curated bell-only
   SF2 in the package (~1–10 MB) for out-of-the-box use.
3. **Allow user-supplied SoundFonts**: a config field for an extra SF2
   path (e.g. `~/.local/share/grandfatherclock/soundfonts/*.sf2`) so
   users can drop in any bell, carillon, or instrument SF2 they want.
4. **Render on demand via FluidSynth**:
   - On first play of a `(chime, bell)` pair, invoke FluidSynth
     (`libfluidsynth` if we link against it, or `fluidsynth` CLI as a
     subprocess) to render the MIDI through the chosen SF2 to a WAV
     in the user cache dir
     (`~/.cache/grandfatherclock/<chime>__<bell>.wav`).
   - Subsequent plays read directly from cache — same latency as the
     current pre-rendered approach.
5. **Cache management**: invalidate cache entries when the source MIDI
   or SF2 mtime changes; expose a "Clear chime cache" button in
   Appearance config.

### Tradeoffs

- **Pros:** tiny base package (~1–10 MB instead of scaling linearly
  with `chimes × bells`); clean orthogonal selection model; users can
  customize bells without us re-shipping.
- **Cons:** adds `fluidsynth` (Arch: `extra/fluidsynth`, ~3 MB) as a
  runtime dependency; first-play latency of 1–3 s while a (chime,
  bell) pair renders for the first time; need cache-management code.

### Implementation order (when we get to it)

1. Confirm BHI permission status (or commit to re-derived sequences).
2. Pick or commission a default bell SF2; vendor it under
   `package/contents/soundfonts/default-bells.sf2`.
3. Add `fluidsynth` as a dependency (PKGBUILD / install instructions).
4. Add a small QML/C++ helper that runs FluidSynth and writes WAV to
   `XDG_CACHE_HOME/grandfatherclock/`.
5. Replace `ChimeEngine._resolve(name)` with a function that resolves
   to the cached render path, kicking off a render if the cache miss.
6. Surface "Bell" as a third axis in the chime config alongside
   "Chime" and existing "Interval".
7. Document how users install custom SF2 files.

The current engine queue + `MediaPlayer` plumbing can stay as-is — the
change is entirely in how source URLs are produced.
