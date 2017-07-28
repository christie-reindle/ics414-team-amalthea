int getStockColor(float cp){
  float stockColor;
  cp += 5.0;
  stockColor = cp*3.3;
  if(stockColor > 33.0){
    stockColor = 33.0;
  }
  return int(stockColor);
}  