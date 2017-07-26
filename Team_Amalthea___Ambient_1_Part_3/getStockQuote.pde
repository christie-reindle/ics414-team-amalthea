import java.util.Random;

float getStockQuote() {
    String stockUrl = "https://www.google.com/finance/info?q=NASDAQ:";
    
    String[] stocks = {"MU","STX","QQQ","BBBY","MSFT","HBAN","AAPL","SIRI","CMCSA","INTC","FB","CSCO","NVDA","SRPT","FOXA","TLT","SPLS","GILD","JD","JBLU"};
    Random rand = new Random();
    int  n = rand.nextInt(stocks.length);
    String stockSymbol = stocks[n];
    
    stockUrl += stockSymbol;
    
    String[] lines = loadStrings(stockUrl);
    String str = join(lines, " ");
    
    int start = str.indexOf("cp") + 7;
    int end = str.indexOf("\"", start);
    String cp = str.substring(start, end);
    
    println(stockSymbol);
    return float(cp);
}