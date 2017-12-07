/**
 * iBeacon Trilateration Demo
 */

import Jama.*;
import controlP5.*;
import oscP5.*;
import netP5.*;

ControlP5 cp5;
OscP5 oscP5;


// Declare anchor distance variables
float Range1 = 0;
float Rx1 = 0;
float Range2 = 0;
float Rx2 = 0;
float Range3 = 0;
float Rx3 = 0;

//*********Variable for Matrix B***********
// Distance between anchors and reference anchor (anchor 1)
float d21, d31;  // Distance between the anchor_i and reference anchor
double b21 = 0;  // Element of Matrix B must be double data type for operating with Matrix lib
double b31 = 0;  // Element of Matrix B must be double data type for operating with Matrix lib

// Matrix declaration
Jama.Matrix AT, X1, A, ATA, ATAI, B, X;

// 3 color for 3 anchor
color color1 = color(198, 181, 232);
color color2 = color(137, 185, 197);
color color3 = color(235, 241, 251);

// Create text field to input anchor's position
float xA1, xA2, xA3, yA1, yA2, yA3;    // Position of anchors
int xpos = 50;
int xspace = 40;
// Declare input anchors' position  
point_loca mypoint_loca_1;
point_loca mypoint_loca_2;
point_loca mypoint_loca_3;
// Declare anchor drawing object
anchor_draw anchorA;
anchor_draw anchorB;
anchor_draw anchorC;
// Declare tag
tag_draw tag;

//Create font
PFont font1 = createFont("Cambria Bold", 20, false);
PFont font2 = createFont("Georgia", 20, false);

//Operating Mode
int Mode = 0;  //Mode = 0: Anchor position setting; Mode = 1: Positioning Operation

//PImage bg = loadImage("back.png");
void setup()
{
  // Load background
  PImage bg = loadImage("back.png");
  size(1200, 650);
  background(bg);

  // Add controlP5
  cp5 = new ControlP5(this);

  // Begin OSC listener
  oscP5 = new OscP5(this, 12000);

  //                   point_loca(color , xpos      , ypos, textField, textCaption, labelName, labelText, font)
  mypoint_loca_1 = new point_loca(color1, xpos      , 350, "A1", "Anchor 1", "1", "A1", font1);
  mypoint_loca_2 = new point_loca(color2, xpos + 400, 350, "A2", "Anchor 2", "2", "A2", font1);
  mypoint_loca_3 = new point_loca(color3, xpos + 800, 350, "A3", "Anchor 3", "3", "A3", font1);

  // Create Done button
  PImage[] img_Done = {
    loadImage("Done_a.png"), loadImage("Done_b.png"), loadImage("Done_c.png")
  };
  cp5.addButton("Done")
     .setPosition(1000, 550)
     .setImages(img_Done)
     .updateSize()
     ;

  // Create Back button
  PImage[] img_Back = {
    loadImage("Back_a.png"), loadImage("Back_b.png"), loadImage("Back_c.png")
  };
  cp5.addButton("Back")
     .setPosition(1000, 5)
     .setImages(img_Back)
     .updateSize()
     .hide()
     ;    

  // Create Notification 
  cp5.addTextlabel("Noti")
     .setText("ATA is Singular \nPlease try another position")
     .setPosition(200, 510) 
     .setColorValue(0xffff0000)
     .setFont(createFont("Cambria Bold", 30, false))
     .hide()
     ;
  // Previous position of anchors
  xA1 = 0;
  yA1 = 0;
  xA2 = 10;
  yA2 = 0;
  xA3 = 10;
  yA3 = 10;
}
void draw()
{
  switch(Mode)
  {
    // Anchor position setting
  case 0:
    PImage bg = loadImage("back.png");
    background(bg);
//    mypoint_loca_1.turnOn();
//    mypoint_loca_2.turnOn();
//    mypoint_loca_3.turnOn();
//    cp5.getController("Done").show();
//    cp5.getController("Back").hide();
    break;
  case 1:
    background(0);
    frameRate(30);
    // Turn off loca
//    mypoint_loca_1.turnOff();
//    mypoint_loca_2.turnOff();
//    mypoint_loca_3.turnOff();
//    cp5.getController("Done").hide();
//    cp5.getController("Back").show();
    // Drawing anchor's sphere 
    anchorA.Anchor_draw(Range1,Rx1);
    anchorB.Anchor_draw(Range2,-97.20);
    anchorC.Anchor_draw(Range3,-97.15);
    
    //*******Calculate the position of tag*********
    // Calculate Matrix B first
    b21 = (pow(Range1,2) - pow(Range2,2) + pow(d21,2))/2;  // b21 = 1/2*(r1^2 - r2^2 + d21^2)
    b31 = (pow(Range1,2) - pow(Range3,2) + pow(d31,2))/2;  // b31 = 1/2*(r1^2 - r3^2 + d31^2)
    B.set(0,0,b21);
    B.set(1,0,b31);
    X = ATAI.times(AT);
    X = X.times(B);
    X = X.plus(X1);
    //X.print(5,2);
    tag.Tag_show(X.get(0,0),X.get(1,0));
    break;
  }
}
// Receive anchor position
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
// Serve for Done button

public void Done()
{
  println("ahihi");
  // Calculate Matrix stuff
  double[][] valA = {{xA2-xA1, yA2-yA1}, {xA3-xA1, yA3-yA1}};
  double[] valX1 = {xA1, yA1};
  X1 = new Jama.Matrix(valX1, 2);
  A = new Jama.Matrix(valA);
  // Calculate Transpose matrix A 
  AT = A.transpose();
  // Calculate AT x A
  ATA= AT.times(A);
  // If ATA is nonsingular
  // Calculate inverse matrix of AT x A
  if (ATA.det() != 0)
  {
    ATAI = ATA.inverse();
    ATAI.print(5, 2);
    // Create Matrix B
    double[] valB = {b21,b31};
    B = new Jama.Matrix(valB, 2);
    // Create anchors        (color,  name, xpos, ypos, range, labelxpos, labelypos, font)
    anchorA = new anchor_draw(color(150,0,0), "A",  xA1,  yA1,  3, 1000, 50, font1);
    anchorB = new anchor_draw(color(0,150,0), "B",  xA2,  yA2,  4, 1000, 110, font1);
    anchorC = new anchor_draw(color(0,0,150), "C",  xA3,  yA3,  5, 1000, 170, font1);
    // Create tag      (color, name, xpos, ypos, labelxpos, labelypos, font) 
    tag = new tag_draw(color(150,150,0), "tag", 5, 5, 1000, 250, font1); 
    // Positioning mode
    mypoint_loca_1.turnOff();
    mypoint_loca_2.turnOff();
    mypoint_loca_3.turnOff();
    cp5.getController("Done").hide();
    cp5.getController("Back").show();    
    anchorA.show_label();
    anchorB.show_label();
    anchorC.show_label();      
    tag.show_label();

    
    Mode =1;
  }
  else 
  {
    println("ATA is Singular");
    cp5.getController("Noti").show();
    cp5.getController("Noti").setStringValue("Please put the anchors in another position");
    
    // Position setting mode 
    mypoint_loca_1.turnOn();
    mypoint_loca_2.turnOn();
    mypoint_loca_3.turnOn();
    cp5.getController("Done").show();
    cp5.getController("Back").hide();    
    anchorA.hide_label();
    anchorB.hide_label();
    anchorC.hide_label();
    tag.hide_label();
    
    Mode =0;
  }
  // Calculate distance between Anchor 1 and Anchor 2 (r1)
  d21 = sqrt(pow(xA2-xA1, 2) + pow(yA2-yA1, 2));
  d31 = sqrt(pow(xA3-xA1, 2) + pow(yA3-yA1, 2));

  X1.print(5, 2);
  A.print(5, 2);
  AT.print(5, 2);
  ATA.print(5, 2);
  println(d21);
  println(d31);
}
// Turn back to edit anchor position
public void Back()
{
  println("ahuhu");
  anchorA.hide_label();
  anchorB.hide_label();
  anchorC.hide_label();  
  mypoint_loca_1.turnOn();
  mypoint_loca_2.turnOn();
  mypoint_loca_3.turnOn();
  cp5.getController("Done").show();
  cp5.getController("Back").hide();   
  tag.hide_label();
  Mode =0;
}

