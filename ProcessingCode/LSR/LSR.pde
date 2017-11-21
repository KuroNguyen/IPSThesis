/**
 * iBeacon Trilateration Demo
 */

import Jama.*;
import controlP5.*;

ControlP5 cp5;

double[][] vals = {
  {
    1., 2., 3
  }
  , {
    4., 5., 6.
  }
  , {
    7., 8., 10.
  }
};
Jama.Matrix A = new Jama.Matrix(vals);
Jama.Matrix k = A.transpose();
float xA1, xA2, xA3, yA1, yA2, yA3;
int xpos = 100;
int xspace = 40;

color color1 = color(198, 181, 232);
color color2 = color(137, 185, 197);
color color3 = color(235, 241, 251);

point_loca mypoint_loca_1;
point_loca mypoint_loca_2;
point_loca mypoint_loca_3;


void setup()
{
  background(0);
  size(1000, 600);

  PFont font1 = createFont("Cambria Bold", 15);
  PFont font2 = createFont("Georgia", 20);

  cp5 = new ControlP5(this);

  //                   point_loca(color , xpos      , ypos, textField, textCaption, labelName, labelText, font)
  mypoint_loca_1 = new point_loca(color1, xpos, 300, "A1", "Anchor 1", "1", "A1", font1);
  mypoint_loca_2 = new point_loca(color2, xpos + 300, 300, "A2", "Anchor 2", "2", "A2", font1);
  mypoint_loca_3 = new point_loca(color3, xpos + 600, 300, "A3", "Anchor 3", "3", "A3", font1);
}
void draw()
{
  background(0);
}
void controlEvent(ControlEvent theEvent) 
{
  if (theEvent.isAssignableFrom(Textfield.class)) 
  {
    println("controlEvent: accessing a string from controller '"
      +theEvent.getName()+"': "
      +theEvent.getStringValue()
      );
    if (theEvent.getName().equals("XA1"))
    {
      xA1 = float(theEvent.getStringValue()); 
      println("xA1 is: " + xA1);
      mypoint_loca_1.setTextX("XA1: "+xA1);
    }
    else if (theEvent.getName().equals("YA1"))
    {
      yA1 = float(theEvent.getStringValue()); 
      println("yA1 is: " + yA1);
      mypoint_loca_1.setTextY("YA1: "+yA1);
    }
    else if (theEvent.getName().equals("XA2"))
    {
      xA2 = float(theEvent.getStringValue()); 
      println("xA2 is: " + xA2);
      mypoint_loca_2.setTextX("XA2: "+xA2);
    }    
    else if (theEvent.getName().equals("YA2"))
    {
      yA2 = float(theEvent.getStringValue());
      println("yA2 is: " + yA2);
      mypoint_loca_2.setTextY("YA2: "+yA2);
    } 
    else if (theEvent.getName().equals("XA3"))
    {
      xA3 = float(theEvent.getStringValue());
      println("xA3 is: " + xA3);
      mypoint_loca_3.setTextX("XA3: "+xA3);
    }
    else if (theEvent.getName().equals("YA3"))
    {
      yA3 = float(theEvent.getStringValue());
      println("yA3 is: " + yA3);
      mypoint_loca_3.setTextY("YA3: "+yA3);
    }
  }
}
