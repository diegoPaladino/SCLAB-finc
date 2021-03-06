//+------------------------------------------------------------------+
//|                                            teste140620202025.mq5 |
//|                                                    diegoPaladino |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "diegoPaladino"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Trade\Trade.mqh>
CTrade trade;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   double ask, bid, last;
   double smaArray[];
   int smaHandle;
   
   ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   last = SymbolInfoDouble(_Symbol, SYMBOL_LAST);
   
   smaHandle = iMA(_Symbol, _Period, 20, 0, MODE_SMA, PRICE_CLOSE);
   ArraySetAsSeries(smaArray, true);
   CopyBuffer(smaHandle, 0, 0, 3, smaArray);
   
   if(last>smaArray[0] && PositionsTotal()==0)
     {
         Comment("Compra");
         trade.Buy(10, _Symbol, ask, ask-200, ask+200, "");
     }
   else if(last<smaArray[0] && PositionsTotal()==0)
     {
         Comment("Venda");
         trade.Sell(10, _Symbol, bid, bid-200, bid+200, "");
     }
  }
//+------------------------------------------------------------------+
