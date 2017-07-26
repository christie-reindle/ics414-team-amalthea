import controlP5.*;
import java.lang.Integer;

PImage photo;
PImage photoCopy;
ControlP5 cp5;
boolean refreshImage;
float adjustbrightness;
int time;
 
void setup() {
  size(400, 400);
  colorMode(HSB, 99);
  noStroke();
  String url = "https://processing.org/img/processing-web.png";
  photo = loadImage(url, "png");
  photo.resize(400, 200);
  photoCopy = photo.get();
  cp5 = new ControlP5(this);  
  
  int input = getInflowOutflow();
  
  // stock change percentage
  float cp = getStockQuote();
  println(cp);
  
  // Convert outflow and inflow values to single color and brightness value
  int colorVal;
  int brightVal;
  // Red and Dark (danger)
  if (input < 0){
    colorVal = 0;
    brightVal = 0;
  }
  // Yellow and Dim (warning)
  else if (input < 800) {
    colorVal = 14;
    brightVal = 33;
  }
  // Green and Bright(OK)
  else if (input < 1200) {
    colorVal = 32;
    brightVal = 66;
  }
  // Blue and Littt (safe)
  else {
     colorVal = 64;
     brightVal = 99;
  }
  
  cp5.addSlider("Brightness_Level")
    .setRange(0, 99)
      .setValue(brightVal)
        .setPosition(100, 370)
          .setSize(100, 10);
          
  cp5.addSlider("Color_Level")
    .setRange(0, 99)
      .setValue(colorVal)
        .setPosition(100, 385)
          .setSize(100, 10);
  loop();
}

float col = 0;
void draw() {
  background(col,255,255);
  if (refreshImage) updateImage();
  image(photoCopy, 0, 0);
}
 
void Brightness_Level() {
  adjustbrightness = cp5.getController("Brightness_Level").getValue();
  refreshImage = true;
}

void Color_Level() {
  col = cp5.getController("Color_Level").getValue();
  refreshImage = true;
}
 
void updateImage() {
  photoCopy = photo.get();
  photoCopy.loadPixels();
  for (int x = 0; x < photoCopy.width; x++) {
    for (int y = 0; y < photoCopy.height; y++ ) {
      int loc = x + y*photoCopy.width;
      float h, b;
      h = hue(photoCopy.pixels[loc]);
      b = brightness(photoCopy.pixels[loc]);
      b += adjustbrightness;
      color c = color(h, 5, b);
      photoCopy.pixels[y*photoCopy.width + x] = c;
    }
  }
  photoCopy.updatePixels();
  refreshImage = true;
  if (second()%10==0)
    {
    setup();
    time = millis();
  }
}