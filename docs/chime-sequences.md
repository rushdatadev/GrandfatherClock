# Clock Chime Sequences — Reference

A catalog of bell-strike sequences for traditional clock chimes, indexed
by bell count, transcribed from the British Horological Institute's
"Chime and Carillons" page.

## Source attribution

- **Title:** Chime and Carillons
- **Editors:** T. Harrison-Smith MBHI, Eliot Isaacs FBHI
- **Original article:** *Horological Journal*, December 1941
- **Publisher of web compilation:** British Horological Institute Ltd (BHI)
- **Web source (archived):** https://web.archive.org/web/20080516220300/http://www.bhi.co.uk/aHints/chimes.html
- **Wayback snapshot date:** 2008-05-16
- **Local copy:** `Saved Web Pages/bhi - clocks, watches & the art and science of timekeeping.html` (in this repo)

## Source license notice

Quoted verbatim from the BHI page footer:

> ©2008 bhi ltd - you are welcome to make use of the information on these
> pages for private, non-commercial use only. For commercial use please
> contact us.

### Implication for this project

The Grandfather Clock plasmoid is licensed **GPL-2.0-only**, which permits
commercial redistribution. BHI's "non-commercial use only" notice is
therefore **incompatible with embedding these sequences directly in the
GPL-licensed widget package** without explicit permission from BHI.

Practical options, in order of safety:

1. **Use this file as developer-only reference.** Do not bake BHI's
   transcribed sequences into the shipped plasmoid as data tables.
2. **Contact BHI** (per their notice) to request permission for use in
   a GPL-licensed open-source project.
3. **Re-derive** sequences from primary sources for the chimes you
   actually want to ship. Many of the underlying tunes (Westminster,
   Canterbury, Whittington, etc.) date to the 18th–19th centuries and
   the tunes themselves are almost certainly public domain — but BHI's
   particular *transcription/compilation* is what their notice covers.
4. **Compose** new sequences using the listed bell tunings as a
   starting point.

This file itself is reference material in the source repo, not a
distributed runtime asset. Keep that distinction in mind before adding
`#include`-style references from runtime code.

## How to read these sequences

Conventions used by the BHI page (transcribed verbatim from its preamble):

- **Hammer numbering:** "The hammers are numbered in such a way that
  the longest chime rod (or lowest note/bell) is number 1. These do not
  take into account the striking hammer, which is often a few notes
  lower than the lowest note of the chime sequence."
- **Quarters:** Each entry lists the hammer sequence for the four
  quarter chimes — 1st quarter (:15), 2nd quarter / half hour (:30),
  3rd quarter (:45), and 4th quarter (top of the hour, :00). On the
  hour the striking hammer also tolls the hour count separately.
- **Note pitches:** Some entries also list the actual pitch each
  hammer number corresponds to (e.g. `1=D 2=G 3=A 4=B`).
- **Sequence punctuation:** The original page uses commas between bells
  within a phrase and a space (or comma-space) between phrases. We
  preserve the original punctuation in the sequences below.
- **Empty sequence fields:** Where the page lists a chime name with
  empty `1st quarter` / `2nd quarter` / etc. fields, the source did
  not provide a transcription. We mark those as **"(not provided in
  source)"** rather than fill them in.

## Chimes by bell count

### Two-bell chimes

#### Tin Tan
- **Notes:** `1=B  2=C`
- **1st quarter:** `2,1`
- **2nd quarter:** `2,1, 2,1`
- **3rd quarter:** `2,1 2,1, 2,1`
- **4th quarter:** `2,1 2,1, 2,1, 2,1`
- **Source note:** "This chime is usually sounded once on the quarter,
  twice on the half hour and three times on the 3rd quarter. In some
  cases it is the sounded 4 times on the hour, but it can be left off
  to prevent confusion with the striking of the hours."

### Three-bell chimes

#### Hampstead
- **Notes:** `1=D  2=F  3=A`
- **1st quarter:** `3,2,1`
- **2nd quarter:** `3,2,1, 1,3,2`
- **3rd quarter:** `3,2,1, 1,3,2, 1,2,3`
- **4th quarter:** `3,2,1, 1,3,2, 1,2,3, 2,3,1`

#### Nafferton
- **Notes:** `1=F#  2=G#  3=A#`
- **1st quarter:** `1,2,3,1`
- **2nd quarter:** `3,1,2,3, 3,2,3,1`
- **3rd quarter:** `1,3,2,1, 1,2,1,3, 1,2,3,1`
- **4th quarter:** `3,1,2,3, 3,1,2,1, 3,2,1,2, 1,2,3,1`

### Four-bell chimes

#### Copenhagen
- **Notes:** `1=E  2=G  3=A  4=B`
- **1st quarter:** `4,3,2,1`
- **2nd quarter:** `1,3,4,2, 1,2,3,4`
- **3rd quarter:** `1,2,3,4, 4,3,2,3, 3,4,2,1`
- **4th quarter:** `1,3,4,2, 1,2,3,4, 4,3,2,3, 3,4,2,1`

#### Dorking
- **Notes:** `1=Bb  2=C  3=D  4=Eb`
- **1st quarter:** `4,2,3,1`
- **2nd quarter:** `3,2,4,1, 2,4,3,1`
- **3rd quarter:** `4,3,2,1, 2,3,4,1, 4,2,3,1`
- **4th quarter:** `3,2,4,1, 2,4,3,1, 4,3,2,1, 2,3,4,1`

#### Lostwithiel
- **Notes:** `1=Bb  2=C  3=Db  4=Eb`
- **1st quarter:** `4,2,3,1`
- **2nd quarter:** `2,3,4,1, 2,1,4,3`
- **3rd quarter:** `4,3,2,1, 2,3,1,2, 4,2,3,1`
- **4th quarter:** `2,3,4,1, 2,1,4,2, 4,3,2,1, 2,3,1,2`

#### Parsifal
- **Notes:** `1=C  2=Eb  3=F  4=Ab`
- **1st quarter:** `4,2,3,1`
- **2nd quarter:** `4,2,3,1, 4,2,3,1`
- **3rd quarter:** `4,2,3,1, 4,2,3,1, 4,2,3,1`
- **4th quarter:** `4,2,3,1, 4,2,3,1, 4,2,3,1, 4,2,3,1`

#### Potsdam
- **Notes:** `1=C  2=F  3=G  4=A`
- **1st quarter:** `1,2,2,3,3,4,3,2`
- **2nd quarter:** `1,2,2,3,3,4,3,2  1,2,2,3,3,4,3,2`
- **3rd quarter:** `1,2,2,3,3,4,3,2, 1,2,2,3,3,4,3,2, 1,2,2,3,3,4,3,2`
- **4th quarter:** `1,2,2,3,3,4,3,2, 1,2,2,3,3,4,3,2, 1,2,2,3,3,4,3,2, 1,2,2,3,3,4,3,2`

#### Silchetser
- **Notes:** `1=F#  2=G#  3=A  4=C#`
- **1st quarter:** `4,3,2,1`
- **2nd quarter:** `4,3,2,1, 2,1,4,3`
- **3rd quarter:** `1,3,2,4, 1,4,3,2, 4,1,2,3`
- **4th quarter:** `2,4,3,2, 3,2,1,4, 3,4,1,2, 4,2,3,1`
- **Caveat:** Likely a typographic error in the source for **Silchester**
  (the Hampshire village). Preserved as printed.

#### Westminster (or Cambridge)
- **Notes:** `1=D  2=G  3=A  4=B`
- **1st quarter:** `4,3,2,1`
- **2nd quarter:** `2,4,3,1, 2,3,4,2`
- **3rd quarter:** `4,2,3,1, 1,3,4,2, 4,3,2,1`
- **4th quarter:** `2,4,3,1, 2,3,4,2, 4,2,3,1, 1,3,4,2`
- **Note:** This is the chime familiar from the Palace of Westminster
  ("Big Ben"), and is the same set of phrases shipped as
  `Westminister*.au` in the upstream `grandfatherclock` audio resources
  (note the upstream's misspelling).

### Five-bell chimes

#### Canterbury Cathedral
- **Notes:** `1=E  2=G  3=A  4=B`
- **1st quarter:** `4,3,2,1`
- **2nd quarter:** `1,3,4,2, 1,2,3,4`
- **3rd quarter:** `1,2,3,4, 4,3,2,3, 3,4,2,1`
- **4th quarter:** `1,3,4,2, 1,2,3,4, 4,3,2,3, 3,4,2,1`
- **Caveat:** Listed under "Five Bell Chimes" but the source only
  provides four notes (no `5=...`) and the sequences only reference
  hammers 1–4. Sequences are identical to *Copenhagen* above.
  Likely either a misclassification or a missing fifth-bell note in the
  source.

#### Fort Augustus NB
- **Notes:** `1=A  2=B  3=C  4=D  5=C`
- **1st quarter:** `3,2,4,3`
- **2nd quarter:** `3,2,4,3, 3,2,4,5`
- **3rd quarter:** `3,2,4,3, 3,2,4,5, 5,3,4,3`
- **4th quarter:** `3,2,4,3, 3,2,4,5, 5,3,4,3, 1,3,4,3`
- **Caveat:** Source lists `3=C` and `5=C`. Likely a transcription typo
  (perhaps `5=Eb` or another upper-octave note intended). Preserved as
  printed.

#### Gonville and Caius
- **Notes:** `1=C  2=D  3=F  4=C  5=A`
- **1st quarter:** `2,1`
- **2nd quarter:** `1,2,4,3`
- **3rd quarter:** `4,5,4,3,1,2`
- **4th quarter:** `1,3,4,5,3,1,2,3`
- **Caveat:** Source lists `1=C` and `4=C`. May be a printing
  collision or an octave displacement; preserved as printed.

#### Keighley
- **Notes:** `1=F  2=G  3=A  4=Bb  5=C`
- **1st quarter:** `4,3,2,1`
- **2nd quarter:** `4,3,2,1, 3,1,2`
- **3rd quarter:** `5,3,2,1, 2,3,2,1`
- **4th quarter:** `3,2,1, 5,3,2,1, 2,3,2,1`

#### Lourdes (Ave Maria)
- **Notes:** `1=F  2=G  3=A  4=Bb  5=C`
- **1st quarter:** `3,2,2,1`
- **2nd quarter:** `3,2,2,1, 3,2,2,1`
- **3rd quarter:** `3,2,2,1, 3,2,2,1, 3,2,2,1`
- **4th quarter:** `1,4,4,3 3,2,2,2, 5,3,4,4,3, 3,2,2,3,2,1`

#### Norwich
- **Notes:** `1=F#  2=G#  3=A  4=B  5=C#`
- **1st quarter:** `5,4,3,2,1`
- **2nd quarter:** `1,2,5,4,3, 4,1,3,2,1`
- **3rd quarter:** `1,2,3,5,1, 3,5,4,2,3, 1,2,4,3,1`
- **4th quarter:** `5,2,3,4,1, 2,3,4,3,5, 1,5,4,3,2, 4,3,2,1,5`

#### Palmers Green
- **Notes:** `1=F  2=G  3=A  4=Bb  5=C`
- **1st quarter:** `5,3,4,2,5,3,1`
- **2nd quarter:** `5,3,4,2,5,3,1, 2,3,4,3,2,5,3,1`
- **3rd quarter:** `5,3,4,2,5,3,1, 2,3,4,3,2,5,3,1, 5,3,4,2,5,3,1`
- **4th quarter:** `5,3,4,2,5,3,1, 2,3,4,3,2,5,3,1, 5,3,4,2,5,3,1, 2,3,4,3,2,1`

#### R.C. Church Cambridge
- **Notes:** (not provided in source)
- **All quarters:** (not provided in source)

#### Stoke St Gregory
- **Notes:** (not provided in source)
- **All quarters:** (not provided in source)

#### Tennyson (or Carafx)
- **Notes:** `1=A  2=B  3=C  4=E`
- **All quarters:** (not provided in source)
- **Caveat:** Listed as a five-bell chime but only four notes given.

### Six-bell chimes

#### Canterbury
- **Notes:** `1=D  2=E  3=F#  4=G  5=A  6=C`
- **1st quarter:** `6,4,2,5,3,1`
- **2nd quarter:** `2,4,6,3,1, 5, 4,6,2,5, 1,4`
- **3rd quarter:** `1,6,4,1,3, 5,4,6,2,5, 1,3,6,4,2, 3,5,1`
- **4th quarter:** `3,1,6,4,2, 5,4,6,2,5, 1,3,3,1,6, 4,2,5,4,6, 5,2,3,1`

#### Kroonstad
- **Notes:** `1=E  2=F#  3=G#  4=A  5=B  6=C#`
- **1st quarter:** `1,3,5`
- **2nd quarter:** `6,5,4,3,2,4,3`
- **3rd quarter:** `5,4,3,2,1,2,3,4,5,3,4,5`
- **4th quarter:** `1,2,3,4,5,4,3,6,5,4,3,2,1,2`

#### Trinity
- **Notes:** (not provided in source)
- **All quarters:** (not provided in source)

#### Winchester
- **Notes:** (not provided in source)
- **All quarters:** (not provided in source)

### Seven-bell chimes

#### Eaton Socon
- **Notes:** `1=D  2=E  3=F  4=G  5=A  6=B  7=C`
- **1st quarter:** `2,3,1,4`
- **2nd quarter:** `2,3,1,4, 5,6,4,7`
- **3rd quarter:** `2,3,1,4, 5,6,4,7, 6,5,7,1`
- **4th quarter:** `2,3,1,4, 5,6,4,7, 6,5,7,1, 5,6,4,2`

### Eight-bell chimes

#### British Grenadiers
- **Notes:** (not provided in source)
- **All quarters:** (not provided in source)

#### Cairo
- **Notes:** `1=F  2=G  3=A  4=Bb  5=C  6=D  7=E  8=F`
- **All quarters (single sequence):** `3,4,5,6,5, 4,3,2,3,1, 5,8,7,6,5, 4,3,2,1,2, 3,4,2,2,3, 2,1,4,3,2, 3,5,8,5,6, ,7,8,7,6, 5,3,1,4,3, 2,1`
- **Caveat:** The source gives a single sequence labeled "All quarters"
  rather than four separate quarter sequences. Also note the spurious
  leading comma in `, 7,8,7,6` mid-sequence — preserved as printed.

#### Denstone College
- **Notes:** `1=C  2=D  3=E  4=F  5=G  6=A  7=B  8=C`
- **1st quarter:** `8,6,4,5`
- **2nd quarter:** `3,8,7,6,5,3,2,4,3`
- **3rd quarter:** `8,6,5,3,2,4,3,5,6,8,7,5,8`
- **4th quarter:** `1,8,7,6,5,4,3,8,7,6,5,3,2,3,4,6,5,2,3,4,5,8,7,6,5,3,5`

#### Guilford
- **Notes:** `1=C  2=D  3=E  4=F  5=G  6=A  7=B  8=C`
- **1st quarter:** `8,3,4,5`
- **2nd quarter:** `3,5,8,7, 2,4,6,5,3`
- **3rd quarter:** `8,5,6,3, 4,2,5,3,6, 4,5,7,8`
- **4th quarter:** `1,5,3,8,7,6,5,3,4,6,2,5,3,4,5,8,7,6,5,3,1,8,7,5,6,2,5`

#### Magdalen College
- **Notes:** `1=C  2=D  3=E  4=F  5=G  6=A  7=B  8=C`
- **1st quarter:** `7,8`
- **2nd quarter:** `7,8,1,5`
- **3rd quarter:** `5,6,4,3,6,2`
- **4th quarter:** `5,6,4,3,5,2,7,8`

#### Notre Dame
- **Notes:** (not provided in source)
- **All quarters:** (not provided in source)

#### New College
- **Notes:** `1=C  2=D  3=E  4=F  5=C  6=A  7=B  8=C`
- **1st quarter:** `6,2`
- **2nd quarter:** `1,2,6,5`
- **3rd quarter:** `6,4,2,5,3,1`
- **4th quarter:** `1,3,2,5,4,6,7,5,8`
- **Caveat:** Source lists `5=C`, repeating the pitch given for `1`
  and `8`. Likely an octave-displacement notation rather than a typo,
  but preserved as printed.

#### St Michaels
- **Notes:** (not provided in source)
- **All quarters:** (not provided in source)

#### The Jones Boys
- **Notes:** `1=A  2=B  3=C#  4=D  5=E  6=E  7=F#  8=G#  9=G#  10=A  11=A`
- **1st quarter:** `6,6,11,1`
- **2nd quarter:** `1,5,6,5,4,3,5,6,5,6,4,3`
- **3rd quarter:** `7,7,7,5,7,7,7,8,9,10,11,5,6,7,4,3,2,1`
- **4th quarter:** `1`
- **Caveat:** Listed under "Eight Bell Chimes" in the source, but the
  note table runs 1–11 and the sequences reference hammer 11. This
  appears to be a misclassification — the chime is effectively an
  11-bell pattern. Preserved under its source heading; cross-reference
  it under eleven-bell when consulting.

### Ten-bell chimes

#### Beverly
- **Notes:** `1=C  2=D  3=E  4=F  5=G  6=A  7=B  8=C  9=D  10=E`
- **1st quarter:** `6,7,4,3,6, 2,7,8,1,5, 9,10`
- **2nd quarter:** `3,5,6,4,2, 9,10,8,1,6, 2, 8,5,3,6, 5,10,9,7,8`
- **3rd quarter:** `3,4,5,6,8, 7,2,4,6,3, 10,9,8,7,5, 3,6,5,8,7, 6,5,4,3,5, 4,2,6,7,8, 5,3,1`
- **4th quarter:** `4,8,1,5,10, 9,8,7,6,5, 2,1,4,3,8, 10,1,5,4,3, 1,6,2,7,9, 10,8,6,4,2, 7,5,3,1,2, 6,5,7,8,9,10`

#### Derby
- **Notes:** `1=C  2=D  3=E  4=F  5=G  6=A  7=B  8=C  9=D  10=E`
- **1st quarter:** `5,6,3,8,2,7,4,1`
- **2nd quarter:** `8,6,4,2,7,5,3,1, 8,7,6,5,4,3,2,1`
- **3rd quarter:** `8,4,7,3,6,2,5,1, 3,5,6,4,7,9,10,8, 5,6,3,8,2,7,4,1`
- **4th quarter:** `8,6,4,2,7,5,3,1, 8,7,6,5,4,3,2,1, 8,4,7,3,6,2,5,1, 3,5,6,4,7,9,10,8`

#### Preston
- **Notes:** (not provided in source)
- **All quarters:** (not provided in source)

### Eleven-bell chimes

#### Trowbridge
- **Notes:** (not provided in source)
- **All quarters:** (not provided in source)

#### Whittington (Bow)
- **Notes:** (not provided in source)
- **All quarters:** (not provided in source)

#### Whittington (American Version)
- **Notes:** (not provided in source)
- **All quarters:** (not provided in source)

### Carillons

The source lists two carillon entries with no further data.

#### Mailines
- **All quarters:** (not provided in source)

#### Elite
- **All quarters:** (not provided in source)

## Source-side notes preserved verbatim

From the page's introduction:

> This page is based on an article published in the Horological Journal
> in December 1941. The idea is that most repairers will only come
> across one or two sets of chimes during their general repairing
> lives. However, there are times when you will come across a chime
> that you have not seen before. This page therefore will show the
> hammer sequence for both the most usual chimes found and a lot of
> unusual chimes that you might never come across.

> Please Note: This page is not complete yet and will be updated as
> time allows. This may well take some time. Your comments would be
> gratefully received.

The 2008-05-16 Wayback snapshot is the latest readily-available
version; the BHI site has since reorganized and the live equivalent
URL no longer resolves to this content.

## Cross-reference: bell counts present

| Bells | Chimes with full sequences           | Chimes with name only          |
|------:|--------------------------------------|--------------------------------|
| 2     | Tin Tan                              | —                              |
| 3     | Hampstead, Nafferton                 | —                              |
| 4     | Copenhagen, Dorking, Lostwithiel, Parsifal, Potsdam, Silchetser, Westminster | — |
| 5     | Canterbury Cathedral, Fort Augustus NB, Gonville and Caius, Keighley, Lourdes, Norwich, Palmers Green | R.C. Church Cambridge, Stoke St Gregory, Tennyson |
| 6     | Canterbury, Kroonstad                | Trinity, Winchester            |
| 7     | Eaton Socon                          | —                              |
| 8     | Cairo, Denstone College, Guilford, Magdalen College, New College, The Jones Boys *(misclassified)* | British Grenadiers, Notre Dame, St Michaels |
| 10    | Beverly, Derby                       | Preston                        |
| 11    | —                                    | Trowbridge, Whittington (Bow), Whittington (American Version) |

> Note: the source has no entries for **9-bell** chimes.

## Working notes for the widget

When/if these sequences are used in the plasmoid (subject to the
license consideration above), the natural data shape mirrors the
source's structure:

```
chime: {
  name: string,
  bellCount: int,
  notes: { [hammerNumber]: pitch },     // e.g. { 1: "D", 2: "G", 3: "A", 4: "B" }
  quarters: {
    1: int[],   // hammer numbers, in strike order
    2: int[],
    3: int[],
    4: int[],
  },
  sourceNote?: string,
  caveat?: string,
}
```

Phrase-grouping (the commas and spaces in the source) is purely
typographical and does not affect striking — at runtime the engine
just walks the flat array of hammer numbers with a fixed inter-strike
delay (and possibly a longer pause at phrase boundaries, if you choose
to preserve that).
