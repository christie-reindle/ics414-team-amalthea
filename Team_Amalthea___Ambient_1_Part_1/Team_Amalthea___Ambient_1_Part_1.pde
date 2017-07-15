import controlP5.*;
import java.lang.Integer;

PImage photo;
PImage photoCopy;
ControlP5 cp5;
boolean refreshImage;
float adjustbrightness;
 
void setup() {
  size(400, 400);
  colorMode(HSB, 99);
  noStroke();
  String url = "https://processing.org/img/processing-web.png";
  photo = loadImage(url, "png");
  photo.resize(400, 200);
  photoCopy = photo.get();
  cp5 = new ControlP5(this);  
  
  // Load data from url into an array of strings
  String dataUrl = "http://www.spk-wc.usace.army.mil/fcgi-bin/hourly.py?report=pnf&textonly=true";
  String[] rawtext = loadStrings(dataUrl);
  
  // Declare outflow and inflow string variables
  String inflow = "";
  String outflow = "";
  
  // Loop through array to find latest available data
  // Then split the tokens, loop through and find first non-NR values for both outflow(index=5) and inflow(index=6)
  for (int i = 55; i > 7; i--) {
    String[] str = splitTokens(rawtext[i]);
    if ((!str[5].equals("-NR-")) && (!str[6].equals("-NR-"))) {
      outflow = str[5];
      inflow = str[6];
      //println("outflow: " + outflow + " inflow: " + inflow);
      i = 7;
    }
  } 
  
  // Outflow and inflow strings to int value
  int out = Integer.parseInt(outflow);
  int in = Integer.parseInt(inflow);
  
  // Convert outflow and inflow values to single color and brightness value
  int colorVal;
  int brightVal;
  // Red and Dark (danger)
  if ((out - in) < 0){
    colorVal = 0;
    brightVal = 0;
  }
  // Yellow and Dim (warning)
  else if ((out - in) < 800) {
    colorVal = 14;
    brightVal = 33;
  }
  // Green and Bright(OK)
  else if ((out - in) < 1200) {
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
  refreshImage = false;
}