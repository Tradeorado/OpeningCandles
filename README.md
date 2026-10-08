# Opening Candles

MetaTrader 5 indicator that marks two configurable daily trading phases (default: 08:00–09:00 and 09:00–10:00) as colored rectangles on the chart. High and low of each box are based on M1 data, independent of the chart timeframe.

*Deutsche Beschreibung: [MQL5_Beschreibung.md](MQL5_Beschreibung.md) · English description: [MQL5_Description_EN.md](MQL5_Description_EN.md)*

## Phases

| Phase | Default time | Default color | Meaning |
|---|---|---|---|
| First opening | 08:00–09:00 | SteelBlue | Futures pre-market phase |
| Second opening | 09:00–10:00 | DarkOrange | XETRA opening |

Each rectangle spans the phase from start to end and from the lowest low to the highest high of the M1 bars in that window. Weekends are skipped.

## Installation

1. In MetaTrader 5: `File → Open Data Folder → MQL5 → Indicators`.
2. Copy `OpeningCandles.mq5` into that folder.
3. Compile it in MetaEditor (F7) or restart MetaTrader.
4. Drag **OpeningCandles** from the Navigator onto a chart.

## Inputs

| Parameter | Default | Description |
|---|---|---|
| `Inp_Farbe1` | SteelBlue | Color of the first opening |
| `Inp_Start1_H` / `Inp_Start1_M` | 08:00 | Start time of the first opening |
| `Inp_Ende1_H` / `Inp_Ende1_M` | 09:00 | End time of the first opening |
| `Inp_Farbe2` | DarkOrange | Color of the second opening |
| `Inp_Start2_H` / `Inp_Start2_M` | 09:00 | Start time of the second opening |
| `Inp_Ende2_H` / `Inp_Ende2_M` | 10:00 | End time of the second opening |
| `Inp_Instanz` | OC1 | Instance name (must be unique per instance) |
| `Inp_TageZurueck` | 20 | Number of days to look back |
| `Inp_Linienbreite` | 1 | Border width in pixels |

## Notes

- Uses M1 data; if not yet loaded at start, it retries up to 10 times at one-second intervals.
- Draws chart objects only (prefix `OC_<instance>_`). No signals, alerts or buffers. Objects are removed with the indicator.
- Set a unique `Inp_Instanz` when running several instances on one chart.
- Times refer to broker server time.
- Not investment advice. Trading involves risk of loss.

## Links

[tradeorado.de](https://tradeorado.de) · [More indicators](https://tradeorado.de/indikatoren/)
