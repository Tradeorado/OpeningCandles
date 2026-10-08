# Opening Candles – Eröffnungsphasen als Rahmen im Chart

**Autor:** tradeorado.de
**Website:** https://tradeorado.de
**Plattform:** MetaTrader 5 (Indikator, Chartfenster)
**Version:** 1.10

## Kurzbeschreibung

Opening Candles markiert täglich zwei konfigurierbare Handelsphasen als farbige Rechtecke im Preischart. Hoch und Tief jedes Rahmens basieren auf M1-Daten, unabhängig vom aktuell gewählten Chart-Timeframe.

## Phasen

| Phase | Standardzeit | Standardfarbe | Bedeutung |
|---|---|---|---|
| Erste Eröffnung | 08:00–09:00 | SteelBlue | Futures-Vorhandelsphase |
| Zweite Eröffnung | 09:00–10:00 | DarkOrange | XETRA-Eröffnung |

Jedes Rechteck reicht vom Start bis zum Ende der Phase und vom tiefsten Low bis zum höchsten High der M1-Bars in diesem Zeitfenster. Wochenenden werden übersprungen.

## Einstellungen

| Parameter | Standard | Bedeutung |
|---|---|---|
| Inp_Farbe1 | SteelBlue | Farbe der ersten Eröffnung |
| Inp_Start1_H / Inp_Start1_M | 08:00 | Startzeit der ersten Eröffnung |
| Inp_Ende1_H / Inp_Ende1_M | 09:00 | Endzeit der ersten Eröffnung |
| Inp_Farbe2 | DarkOrange | Farbe der zweiten Eröffnung |
| Inp_Start2_H / Inp_Start2_M | 09:00 | Startzeit der zweiten Eröffnung |
| Inp_Ende2_H / Inp_Ende2_M | 10:00 | Endzeit der zweiten Eröffnung |
| Inp_Instanz | OC1 | Instanzname (eindeutig pro Instanz) |
| Inp_TageZurueck | 20 | Anzahl Tage zurück |
| Inp_Linienbreite | 1 | Rahmenbreite in Pixeln |

## Hinweise

- Die Berechnung nutzt M1-Daten. Sind diese beim Start noch nicht geladen, versucht der Indikator es bis zu 10-mal im Sekundentakt.
- Der Indikator zeichnet nur Chart-Objekte (Prefix `OC_<Instanz>_`). Er liefert keine Signale, Alerts oder Indikatorpuffer.
- Für mehrere Instanzen auf einem Chart muss `Inp_Instanz` eindeutig sein.
- Beim Entfernen werden alle eigenen Objekte gelöscht.
- Die Zeiten beziehen sich auf die Serverzeit des Brokers.
- Kein Anlageratschlag. Handel mit Finanzinstrumenten ist mit Verlustrisiko verbunden.

## Mehr von tradeorado.de

Weitere Indikatoren: https://tradeorado.de/indikatoren/
