//+------------------------------------------------------------------+
//|                                          MQL5_-_EA_(Parte_6).mq5 |
//|                                                    diegoPaladino |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

//MQL5 - EA (Parte 6) - Variáveis de Entrada (Inputs) - Expert Advisor
//https://www.youtube.com/watch?v=eVmS7U0Cnes


#property copyright "diegoPaladino"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include <Trade\Trade.mqh>
CTrade trade;

input int ma_periodo = 20;          //Período da média
input int ma_desloc = 0;            //Deslocamento da média
input ulong magicNumber = 123456;   //Magic Number
input ulong desvPts = 50;           //Desvio em pontos
input double lote = 1;              //Volume
input double stopLoss = 200;        //Stop Loss
input double takeProfit = 200;      //Take Profit

double ask, bid, last;
double smaArray[];
int smaHandle;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

   smaHandle = iMA(_Symbol, _Period, ma_periodo, 0, MODE_SMA, PRICE_CLOSE);
   ArraySetAsSeries(smaArray, true);
   
   trade.SetTypeFilling(ORDER_FILLING_RETURN);
   trade.SetDeviationInPoints(desvPts);
   trade.SetExpertMagicNumber(magicNumber);
   
   
   
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

   
   ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   last = SymbolInfoDouble(_Symbol, SYMBOL_LAST);
   
   
   CopyBuffer(smaHandle, 0, 0, 3, smaArray);
   
   if(last>smaArray[0] && PositionsTotal()==0)
     {
         Comment("Compra");
         trade.Buy(lote, _Symbol, ask, ask-stopLoss, ask+takeProfit, "");
     }
   else if(last<smaArray[0] && PositionsTotal()==0)
     {
         Comment("Venda");
         trade.Sell(lote, _Symbol, bid, bid-stopLoss, bid+takeProfit, "");
     }
  }