float getStockQuote() {
    String stockUrl = "https://www.google.com/finance/info?q=NASDAQ:";
    String stockSymbol = getStock();
    stockUrl += stockSymbol;
    
    // if bad request to url
    if (loadStrings(stockUrl) == null){
      return getStockQuote();
    }
    else{
      String[] lines = loadStrings(stockUrl);
      String str = join(lines, " ");
      int start = str.indexOf("cp") + 7;
      int end = str.indexOf("\"", start);
      String cp = str.substring(start, end);
    
      //println(stockSymbol);
      return float(cp);
    }
}