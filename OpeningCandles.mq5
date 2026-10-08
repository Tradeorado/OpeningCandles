//+------------------------------------------------------------------+
//|  OpeningCandles.mq5                                              |
//|  Tradeorado — Opening Candles                                    |
//|  Zeichnet Rahmen für die erste und zweite Eröffnungskerze        |
//+------------------------------------------------------------------+
//|  Beschreibung:                                                   |
//|  Dieser Indikator markiert täglich zwei konfigurierbare          |
//|  Handelsphasen als farbige Rechtecke im Chart.                   |
//|                                                                  |
//|  Standardmäßig werden dargestellt:                               |
//|  - Erste Eröffnung   08:00–09:00 Uhr (Futures-Vorhandelsphase)  |
//|  - Zweite Eröffnung  09:00–10:00 Uhr (XETRA-Eröffnung)          |
//|                                                                  |
//|  Hoch und Tief jedes Rahmens basieren auf M1-Daten —            |
//|  unabhängig vom aktuell gewählten Chart-Timeframe.               |
//|  Farben, Uhrzeiten und Rückblickfenster sind frei konfigurierbar.|
//|                                                                  |
//|  Autor: tradeorado.de                                            |
//|  Weitere Indikatoren: https://tradeorado.de/indikatoren/         |
//+------------------------------------------------------------------+
#property copyright   "© 2026 tradeorado.de"
#property link        "https://tradeorado.de"
#property version     "1.10"
#property description "Markiert die erste (08-09 Uhr) und zweite (09-10 Uhr) Eröffnungsphase"
#property description "als farbige Rechtecke im Chart."
#property description "https://tradeorado.de/indikatoren/"
#property indicator_chart_window
#property indicator_plots 0

//--- Eingabeparameter
input group "=== Erste Eröffnung (Standard: 08-09 Uhr) ==="
input color  Inp_Farbe1       = clrSteelBlue;   // Farbe
input int    Inp_Start1_H     = 8;              // Startzeit (Stunde)
input int    Inp_Start1_M     = 0;              // Startzeit (Minute)
input int    Inp_Ende1_H      = 9;              // Endzeit (Stunde)
input int    Inp_Ende1_M      = 0;              // Endzeit (Minute)

input group "=== Zweite Eröffnung (Standard: 09-10 Uhr) ==="
input color  Inp_Farbe2       = clrDarkOrange;  // Farbe
input int    Inp_Start2_H     = 9;              // Startzeit (Stunde)
input int    Inp_Start2_M     = 0;              // Startzeit (Minute)
input int    Inp_Ende2_H      = 10;             // Endzeit (Stunde)
input int    Inp_Ende2_M      = 0;              // Endzeit (Minute)

input group "=== Allgemein ==="
input string Inp_Instanz      = "OC1";          // Instanzname (eindeutig pro Instanz!)
input int    Inp_TageZurueck  = 20;             // Anzahl Tage zurück
input int    Inp_Linienbreite = 1;              // Rahmenbreite in Pixeln

//--- Globale Variablen
string OBJ_PREFIX;
int    g_Retries = 0;
const int MAX_RETRIES = 10;  // Maximal 10 Versuche à 1 Sekunde

//+------------------------------------------------------------------+
//| Zeichenlogik — gibt Anzahl gezeichneter Boxen zurück             |
//+------------------------------------------------------------------+
int AllesZeichnen()
  {
   ObjectsDeleteAll(0, OBJ_PREFIX);
   int drawn = 0;

   for(int day = 0; day < Inp_TageZurueck; day++)
     {
      datetime day_open = iTime(_Symbol, PERIOD_D1, day);
      if(day_open == 0) break;

      MqlDateTime dt;
      TimeToStruct(day_open, dt);
      if(dt.day_of_week == 0 || dt.day_of_week == 6) continue;

      string date_str = StringFormat("%04d%02d%02d", dt.year, dt.mon, dt.day);

      datetime t1s = day_open + Inp_Start1_H * 3600 + Inp_Start1_M * 60;
      datetime t1e = day_open + Inp_Ende1_H  * 3600 + Inp_Ende1_M  * 60;
      datetime t2s = day_open + Inp_Start2_H * 3600 + Inp_Start2_M * 60;
      datetime t2e = day_open + Inp_Ende2_H  * 3600 + Inp_Ende2_M  * 60;

      if(ZeichneSession(t1s, t1e, OBJ_PREFIX + "1_" + date_str, Inp_Farbe1)) drawn++;
      if(ZeichneSession(t2s, t2e, OBJ_PREFIX + "2_" + date_str, Inp_Farbe2)) drawn++;
     }

   ChartRedraw(0);
   return drawn;
  }

//+------------------------------------------------------------------+
//| Initialisierung                                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   OBJ_PREFIX  = "OC_" + Inp_Instanz + "_";
   g_Retries   = 0;
   EventSetTimer(1);  // Erster Versuch nach 1 Sekunde
   return(INIT_SUCCEEDED);
  }

//+------------------------------------------------------------------+
//| Timer — zeichnet und wiederholt falls Daten noch nicht geladen   |
//+------------------------------------------------------------------+
void OnTimer()
  {
   int drawn = AllesZeichnen();

   if(drawn > 0)
     {
      // Daten geladen, Boxen gezeichnet — Timer stoppen
      EventKillTimer();
      g_Retries = 0;
     }
   else
     {
      // Noch keine Daten — erneut versuchen
      g_Retries++;
      if(g_Retries >= MAX_RETRIES)
        {
         // Aufgeben nach MAX_RETRIES Versuchen
         EventKillTimer();
        }
      // Timer läuft weiter (nächster Versuch in 1 Sekunde)
     }
  }

//+------------------------------------------------------------------+
//| Deinitialisierung                                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   EventKillTimer();
   ObjectsDeleteAll(0, OBJ_PREFIX);
   ChartRedraw(0);
  }

//+------------------------------------------------------------------+
//| Hauptfunktion — bei neuem Bar aktualisieren                      |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
   if(prev_calculated > 0 && rates_total == prev_calculated)
      return(rates_total);

   AllesZeichnen();
   return(rates_total);
  }

//+------------------------------------------------------------------+
//| Hilfsfunktion: Rahmen zeichnen — gibt true zurück bei Erfolg     |
//+------------------------------------------------------------------+
bool ZeichneSession(datetime t_start, datetime t_end, string name, color clr)
  {
   MqlRates rates[];
   int count = CopyRates(_Symbol, PERIOD_M1, t_start, t_end, rates);
   if(count <= 0) return false;

   double sess_high = rates[0].high;
   double sess_low  = rates[0].low;
   for(int i = 1; i < count; i++)
     {
      if(rates[i].high > sess_high) sess_high = rates[i].high;
      if(rates[i].low  < sess_low)  sess_low  = rates[i].low;
     }

   if(ObjectFind(0, name) >= 0)
      ObjectDelete(0, name);

   ObjectCreate(0, name, OBJ_RECTANGLE, 0, t_start, sess_high, t_end, sess_low);
   ObjectSetInteger(0, name, OBJPROP_COLOR,       clr);
   ObjectSetInteger(0, name, OBJPROP_STYLE,       STYLE_SOLID);
   ObjectSetInteger(0, name, OBJPROP_WIDTH,       Inp_Linienbreite);
   ObjectSetInteger(0, name, OBJPROP_FILL,        true);
   ObjectSetInteger(0, name, OBJPROP_BACK,        true);
   ObjectSetInteger(0, name, OBJPROP_SELECTABLE,  false);
   ObjectSetInteger(0, name, OBJPROP_HIDDEN,      true);
   return true;
  }
//+------------------------------------------------------------------+