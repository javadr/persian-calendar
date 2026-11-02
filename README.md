# pcalendar

A LaTeX package for the Persian (Jalali, Solar Hijri) calendar. It converts dates between the Persian and Gregorian calendars, prints dates with Persian month names, gives day numbers for date arithmetic, and provides Persian month, weekday and year-animal names. It is built on `pgfcalendar`. The date conversions work with any engine (pdfLaTeX, XeLaTeX, LuaLaTeX); printing the Persian names needs a Unicode engine and a Persian font, for example XeLaTeX with `xepersian`.

It is a date converter and a set of name tables. It does not typeset a month grid or a wall calendar, and it has no holidays.

## Usage

Load `pcalendar` in the preamble. The example below uses `xepersian` and a Persian font so that the Persian names print; any setup that can typeset Persian works. The numeric macros (`\pisodate`, `\gisodate`, the Julian day macros) need nothing else.

```latex
\usepackage{pcalendar}
\usepackage{xepersian}
\settextfont{Parisa}
```

| Macro | Argument | Prints |
|---|---|---|
| `\pdate{Y-M-D}` | Gregorian date | the Jalali date with the month name |
| `\gdate{Y-M-D}` | Jalali date | the Gregorian date with the month name |
| `\pisodate{Y-M-D}` | Gregorian date | the Jalali date as `DD/MM/YYYY` |
| `\gisodate{Y-M-D}` | Jalali date | the Gregorian date as `DD/MM/YYYY` |
| `\pcalendardatetojulian{Y-M-D[+N]}{\count}` | Jalali date | stores its day number in `\count`, after adding `N` days |
| `\pcalendarjuliantodate{\count}{\y}{\m}{\d}` | day number | sets `\y`, `\m`, `\d` to the Jalali date |
| `\pcalendarmonthname{n}`, `\pcalendargregorianmonthname{n}` | 1 to 12 | the Persian name of the month |
| `\pcalendarweekdayname{n}`, `\pcalendarweekdayshortname{n}` | 0 to 6, Saturday is 0 | the weekday name |
| `\pcalendaryearname{year}` | Jalali year, 0 to 2099 | the animal of the year |

```latex
\pdate{2015-03-21}                    % 1 Farvardin 1394, in Persian
\gisodate{1403-01-01}                 % 20/03/2024

\newcount\jd
\pcalendardatetojulian{1394-01-01+10}\jd
\pcalendarjuliantodate\jd\y\m\d
\number\y-\number\m-\number\d         % 1394-1-11
```

The full manual, with every macro, examples and the known limitations, is in English ([`package/doc/pcalendar-doc.tex`](package/doc/pcalendar-doc.tex)) and Persian ([`package/doc/pcalendar-doc-fa.tex`](package/doc/pcalendar-doc-fa.tex)). `package/sample/pcalendar-test.tex` shows every macro with its output.

## Installation

Copy `package/tex/pcalendar.sty` into a directory TeX searches, for example `texmf/tex/latex/pcalendar/`, and run `mktexlsr`. `make dev` does this for you. You can also keep `pcalendar.sty` next to your document.

## Limitations

- Dates must be written as literal `Y-M-D` text. A macro holding a date is not expanded by `\pdate`, `\gdate`, `\pisodate` and `\gisodate`.
- There is no input checking: a month 13 or a malformed string gives wrong output or a TeX error.
- The Jalali leap rule is the 33-year arithmetic approximation, which can differ from the official calendar in some years.
- Every conversion overwrites the package's result registers, so read `\y`, `\m`, `\d` right after `\pcalendarjuliantodate`.
- `\pcalendaryearname` works for 0 to 2099 only.

## Development and testing

The `Makefile` has these targets:

| Target | What it does |
|---|---|
| `make check` | runs the `l3build` regression tests in `package/testfiles/` |
| `make sample` (alias `make test`) | compiles every file in `package/sample/` with XeLaTeX |
| `make doc` | builds the English and Persian manuals |
| `make readme` | regenerates the CTAN `README` from the version and date in the package |
| `make dev` | installs the package into the local TeX tree (uses `sudo`) |
| `make ctan` | builds `pcalendar.zip` for upload: `README`, `tex/` and `doc/` |
| `make clean` | removes build files |

The package itself needs only `pgf`. The samples and manuals typeset Persian text, so they need XeLaTeX, `xepersian` and the Parisa font; the Persian manual also uses XB Niloofar.

The tests in `package/testfiles/` are `l3build` test files. They check known date pairs in both directions (Nowruz of several years, leap days, the last day of Esfand in leap years, month boundaries), the internal helper macros, the Julian day macros, a round trip over 1500 consecutive days, and that no registers are allocated per call. After an intended change, record a new baseline with `l3build save <name>`.

### Releasing

Change `\pcalendardate` and `\pcalendarversion` at the top of `package/tex/pcalendar.sty`, add an entry to `ChangeLogs`, then run `make readme` and `make ctan`. The `Makefile` reads the version and date from those two macros. The CTAN `package/README` is generated, so do not edit it by hand; this `README.md` is for GitHub and is not part of the CTAN archive.

## License

Copyright 2015-2026. Distributed under the LaTeX Project Public License, version 1.3c or later (see <http://www.latex-project.org/lppl.txt>). The work has the LPPL maintenance status "author-maintained".
