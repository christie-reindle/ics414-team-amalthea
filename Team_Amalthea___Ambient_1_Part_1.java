import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Team_Amalthea___Ambient_1_Part_1 extends PApplet {


PImage photo;
PImage photoCopy;
ControlP5 cp5;
boolean refreshImage;
float adjustbrightness;
 
public void setup() {
  
  colorMode(HSB, 255);
  noStroke();
  String url = "https://processing.org/img/processing-web.png";
  photo = loadImage(url, "png");
  photo.resize(400, 200);
  photoCopy = photo.get();
  cp5 = new ControlP5(this);
 
  cp5.addSlider("Brightness_Level")
    .setRange(-128, 127)
      .setValue(0)
        .setPosition(100, 370)
          .setSize(100, 10);
          
  cp5.addSlider("Color_Level")
    .setRange(0, 255)
      .setValue(0)
        .setPosition(100, 385)
          .setSize(100, 10);         
}

float col = 0;
public void draw() {
  background(col,255,255);
  if (refreshImage) updateImage();
  image(photoCopy, 0, 0);
}
 
public void Brightness_Level() {
  adjustbrightness = cp5.getController("Brightness_Level").getValue();
  refreshImage = true;
}

public void Color_Level() {
  col = cp5.getController("Color_Level").getValue();
  refreshImage = true;
}
 
public void updateImage() {
  photoCopy = photo.get();
  photoCopy.loadPixels();
  for (int x = 0; x < photoCopy.width; x++) {
    for (int y = 0; y < photoCopy.height; y++ ) {
      int loc = x + y*photoCopy.width;
      float h, s, b;
      h = hue(photoCopy.pixels[loc]);
      b = brightness(photoCopy.pixels[loc]);
      b += adjustbrightness;
      int c = color(h, 5, b);
      photoCopy.pixels[y*photoCopy.width + x] = c;
    }
  }
  photoCopy.updatePixels();
  refreshImage = false;
}
  public void settings() {  size(400, 400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Team_Amalthea___Ambient_1_Part_1" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
