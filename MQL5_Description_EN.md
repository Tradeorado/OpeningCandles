# Opening Candles – Opening Phases as Boxes on the Chart

**Author:** tradeorado.de
**Website:** https://tradeorado.de
**Platform:** MetaTrader 5 (indicator, chart window)
**Version:** 1.10

## Summary

Opening Candles marks two configurable trading phases per day as colored rectangles on the price chart. The high and low of each box are based on M1 data, independent of the selected chart timeframe.

## Phases

| Phase | Default time | Default color | Meaning |
|---|---|---|---|
| First opening | 08:00–09:00 | SteelBlue | Futures pre-market phase |
| Second opening | 09:00–10:00 | DarkOrange | XETRA opening |

Each rectangle spans the phase from start to end and from the lowest low to the highest high of the M1 bars in that time window. Weekends are skipped.

## Inputs

| Parameter | Default | Description |
|---|---|---|
| Inp_Farbe1 | SteelBlue | Color of the first opening |
| Inp_Start1_H / Inp_Start1_M | 08:00 | Start time of the first opening |
| Inp_Ende1_H / Inp_Ende1_M | 09:00 | End time of the first opening |
| Inp_Farbe2 | DarkOrange | Color of the second opening |
| Inp_Start2_H / Inp_Start2_M | 09:00 | Start time of the second opening |
| Inp_Ende2_H / Inp_Ende2_M | 10:00 | End time of the second opening |
| Inp_Instanz | OC1 | Instance name (must be unique per instance) |
| Inp_TageZurueck | 20 | Number of days to look back |
| Inp_Linienbreite | 1 | Border width in pixels |

## Notes

- Calculation uses M1 data. If it is not yet loaded at start, the indicator retries up to 10 times at one-second intervals.
- The indicator only draws chart objects (prefix `OC_<instance>_`). It provides no signals, alerts or indicator buffers.
- To run several instances on one chart, `Inp_Instanz` must be unique.
- All of its objects are removed when the indicator is removed.
- Times refer to the broker's server time.
- Not investment advice. Trading financial instruments involves risk of loss.

## More from tradeorado.de

More indicators: https://tradeorado.de/indikatoren/
