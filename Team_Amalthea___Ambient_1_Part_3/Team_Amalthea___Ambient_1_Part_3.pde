import java.util.Random;

int out;
int in;
String stockSymbol;
String stockName;

void setup(){
  size(800, 800);
  noStroke();
  colorMode(HSB, 99);
}

void draw(){
  //brightness(getInflowOutflow());
  color c = color(getInflowOutflow(), 100, 100); //0-64
  fill(c);
  rect(0, 0, 400, 800);
  
  float cp = getStockQuote();
  color c2 = color(getStockColor(cp), 100, 100); //0-33
  fill(c2);
  rect(400, 0, 400, 800);
  fill(50);
  textSize(50);
  text(stockSymbol, 550, 400);
  text(getStockQuote()+"%", 530, 450);
}