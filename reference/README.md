# Reference material

Background reading on the Solar Hijri (Jalali) calendar and its leap-year rules, collected while working on `pcalendar`. Nothing here is needed to build or use the package.

## Articles

All five appeared in the Persian journal *Tārīkh-e ʿIlm* (تاریخ علم, *Journal for the History of Science*), published by the Institute for the History of Science, University of Tehran. The PDFs in [`articles/`](articles/) are scans of the printed articles.

| Local copy | Pages | Topic |
|---|---|---|
| [`Aliehyaee_2003_…`](articles/Aliehyaee_2003_On-the-2820-Year-Cycle-in-the-Solar-Hijri-Calendar.pdf) | 14 | The 2820-year cycle |
| [`Sayyad_2003_…`](articles/Sayyad_2003_Mathematical-Model-of-the-Conventional-Lunar-Hijri-Calendar.pdf) | 12 | The lunar (not solar) calendar |
| [`Abdollahi_2004_…`](articles/Abdollahi_2004_Critique-of-the-2820-Year-Cycle-in-the-Solar-Hijri-Calendar.pdf) | 20 | A critique of the 2820-year cycle |
| [`Akrami_2004_…`](articles/Akrami_2004_Computing-the-Best-Intercalation-in-the-Solar-Hijri-Calendar.pdf) | 32 | Computing the best leap-year pattern |
| [`Ghasemlu_2006_…`](articles/Ghasemlu_2006_Comparison-of-Leap-Year-Rules-in-the-Solar-Hijri-Calendar.pdf) | 51 | A survey of leap-year rules |

### 1. Aliehyaee (2003)

**ماشاءالله علی احیایی، «بحثی درباره دورهٔ ۲۸۲۰ سالی در تقویم هجری شمسی»**
M. A. Aliehyaee, *A discussion of the 2820-year cycle in the Solar Hijri calendar*. *Tārīkh-e ʿIlm*, vol. 1, no. 1 (Autumn 1382 / 2003), pp. 39–51.

Explains why a calendar has to be based on the mean length of the solar year, and discusses the 2820-year cycle (Zabih Behruz, Ahmad Birashk).
Download: [journal PDF](https://jihs.ut.ac.ir/article_11493_76cac4685e3749728f9c04bd3a86221f.pdf) · [journal page](https://jihs.ut.ac.ir/article_11493.html)

### 2. Sayyad (2003)

**محمدرضا صیاد، «مدل‌سازی ریاضی برای استخراج تقویم هجری قمری قراردادی»**
M. R. Sayyad, *Mathematical modelling for deriving the conventional lunar Hijri calendar*. *Tārīkh-e ʿIlm*, vol. 1, no. 1 (Autumn 1382 / 2003), pp. 27–37.

Presents two equations for the conventional *lunar* calendar. It is the odd one out in this folder: it does not deal with the solar calendar, so it is only loosely related to `pcalendar`.
Download: [journal PDF](https://jihs.ut.ac.ir/article_11492_89d50fbb82c5341bcb297265b9c0dd6f.pdf) · [journal page](https://jihs.ut.ac.ir/article_11492.html)

### 3. Abdollahi (2004)

**رضا عبداللهی، «نقدی بر دورهٔ ۲۸۲۰ سالی در گاه‌شماری هجری شمسی»**
R. Abdollahi, *A critique of the 2820-year cycle in the Solar Hijri calendar*. *Tārīkh-e ʿIlm*, vol. 2, no. 1 (Autumn 1383 / 2004), pp. 41–59.

A reply to Aliehyaee's article. It follows the use of cycles in Iranian calendars from the Achaemenids to the Sasanians and argues that the cycle has never had a legal basis.
Download: [journal PDF](https://jihs.ut.ac.ir/article_11484_97fc9b260a90d9c0aca468d2e6536980.pdf) · [journal page](https://jihs.ut.ac.ir/article_11484.html) · [Ensani](https://ensani.ir/fa/article/182098)

### 4. Akrami (2004)

**موسی اکرمی، «محاسبهٔ رایانه‌ای بهترین کبیسه‌بندی در گاه‌شماری هجری شمسی»**
M. Akrami, *Computer calculation of the best leap-year pattern in the Solar Hijri calendar*. *Tārīkh-e ʿIlm*, vol. 2, no. 1 (Autumn 1383 / 2004), pp. 61–91.

Uses the mean solar year to compute the best cycle and leap-year pattern. The result is a 2820-year cycle with a special arrangement of sub-cycles.
Download: [journal PDF](https://jihs.ut.ac.ir/article_11485_da4b17317583999c7fc8ba29cfd48b8b.pdf) · [journal page](https://jihs.ut.ac.ir/article_11485.html) · [Ensani](https://ensani.ir/fa/article/182099)

### 5. Ghasemlu (2006)

**فرید قاسملو، «مقایسه روش‌ها و معادلات مختلف برای اعمال کبیسه‌های گاه‌شماری هجری خورشیدی در منابع مختلف»**
F. Ghasemlu, *A comparison of the methods and equations used to place leap years in the Solar Hijri calendar, in various sources*. *Tārīkh-e ʿIlm*, no. 5 (Spring–Summer 1385 / 2006), pp. 93–143.

The broadest survey in the folder: how leap years have been placed since the Jalali calendar appeared in the 5th century AH.
Download: [SID](https://www.sid.ir/fa/journal/ViewPaper.aspx?id=97372) · [author page on Ensani](https://ensani.ir/fa/article/author/52005). A conference version is on [Civilica](https://civilica.com/doc/21769). I did not find a direct PDF link for the journal version on the journal's own site.

## Relevance to `pcalendar`

`pcalendar` uses the 33-year arithmetic leap rule (8 leap years in every 33). Articles 1, 3 and 4 discuss the 2820-year alternative, and article 5 compares the common rules. They are the place to start if you want to check the package against another leap-year rule (see the "Limitations" section of the manuals).

## Other files

- [`code/`](code/): `jalconv.py` and `jdconv.php` (converters used to cross-check results) and a copy of `pgfcalendar.code.tex`.
- [`archive/calendar_2.zip`](archive/calendar_2.zip): an older version of the package.

## Notes

- The download links were taken from the journal and portal pages in November 2026. The `jihs.ut.ac.ir` file names contain a hash, so if a link breaks, search for the title on the [journal page](https://jihs.ut.ac.ir/).
- The articles are the authors' copyrighted work. The local copies are for reference; check the journal's terms before redistributing them.
