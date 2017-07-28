String getStock() {
  String[] lines = loadStrings("NASDAQ.txt");
  Random rand = new Random();
  int  n = rand.nextInt(lines.length);
  String line = lines[n];
  String[] split = splitTokens(line);
  stockSymbol = split[0];
  stockName = split[1];
  for(int i = 2; i < split.length; i++){
    stockName += (" " + split[i]);
  }
  //println(stockSymbol);
  //println(stockName);
  
  return stockSymbol;
}