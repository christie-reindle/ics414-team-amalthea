import java.util.Random;

int out;
int in;
String stockSymbol;

void setup(){
  size(800, 800);
  noStroke();
}

void draw(){
  println(getInflowOutflow());
  brightness(getInflowOutflow());
  color c = color(getInflowOutflow(), 137, 244);
  fill(c);
  rect(0, 0, 400, 800);
  println(int(getStockQuote()*99));
  fill(int(getStockQuote()*99));
  rect(400, 0, 400, 800);
  fill(50);
  textSize(50);
  text(stockSymbol, 550, 400);
  text(getStockQuote(), 530, 450);
}