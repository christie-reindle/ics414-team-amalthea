import controlP5.*;
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
 
  cp5.addSlider("Brightness_Level")
    .setRange(-99, 99)
      .setValue(0)
        .setPosition(100, 370)
          .setSize(100, 10);
          
  cp5.addSlider("Color_Level")
    .setRange(0, 99)
      .setValue(0)
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
      float h, s, b;
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