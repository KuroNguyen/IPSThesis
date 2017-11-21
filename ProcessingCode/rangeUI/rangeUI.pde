/**
 * rangeUI
 * 
 *
 *
 *
 *
 */
import oscP5.*;
import controlP5.*;

OscP5 oscP5;
ControlP5 cp5;

String str;
float estimateRange;

void setup()
{
  size(600, 600);
  frameRate(25);
  oscP5 = new OscP5(this, 12000);
//  cp5 = new ControlP5(this);
//  
//  cp5.addSlider("sliderValue")
//     .setRange(0,5)
//     .setValue(5)
//     .setPosition(100,200)
//     .setSize(500,50);
}

void draw()
{
  background(255);    
}

void oscEvent(OscMessage m)
{
  str = m.get(0).stringValue();
  estimateRange = float(str);
  print(estimateRange);
}

