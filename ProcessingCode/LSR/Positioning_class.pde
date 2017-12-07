class anchor_draw
{
  color c;
  float xpos;
  float ypos;
  float labelXpos;
  float labelYpos;
  float diameter;
  String anchorName;
  PFont font; 
  anchor_draw(color tempC, String tempAnchorName, float tempXpos, float tempYpos, float tempDia, float templabelXpos, float templabelYpos, PFont tempFont)
  {
    c = tempC;
    anchorName = tempAnchorName;
    xpos = map(tempXpos, 0, 10, 0, 600) + 150;
    ypos = map(tempYpos, 0, 10, 0, 600) + 20;
    diameter = map(tempDia, 0, 10, 0, 600);
    labelXpos = templabelXpos;
    labelYpos = templabelYpos;
    font = tempFont;
    // Anchor information
    cp5.addTextlabel("Info"+anchorName)
       .setText("Anchor "+anchorName
               +"\nRange: "+tempDia+" (m)"
               +"\nRX: "+tempDia+" (dBm)")
       .setPosition(labelXpos,labelYpos)
       .setColorValue(c)
       .setFont(font)
       ;    

  }
  void Anchor_draw(float tempDia, float tempRX)
  {
    diameter = map(tempDia, 0, 10, 0, 600);
    // Draw anchor in blue
    noStroke();
    fill(c);
    ellipseMode(CENTER);
    ellipse(xpos, ypos, 20, 20);
    
    // Draw spherical radii of anchor
    stroke(c);
    noFill();
    strokeWeight(5);
    ellipseMode(CENTER);
    ellipse(xpos, ypos, diameter*2, diameter*2);
    
    // Anchor information
    cp5.getController("Info"+anchorName).setStringValue("Anchor "+anchorName
                                                +"\nRange: "+tempDia+" (m)"
                                                +"\nRX: -"+tempRX+" (dBm)")
                                                ;    
  }
  void hide_label()
  {
    cp5.getController("Info"+anchorName).setVisible(false);
  }
  void show_label()
  {
    cp5.getController("Info"+anchorName).setVisible(true);
  }  
}
class tag_draw
{
  color c;
  float xpos;
  float ypos;
  float labelXpos;
  float labelYpos;
  float diameter;
  String tagName;
  PFont font;
  tag_draw(color tempC, String tempTagName, float tempXpos, float tempYpos, float templabelXpos, float templabelYpos, PFont tempFont)
  {
    c = tempC;
    tagName = tempTagName;
    xpos = map(tempXpos, 0, 10, 0, 600) + 150;
    ypos = map(tempYpos, 0, 10, 0, 600) + 20;
    labelXpos = templabelXpos;
    labelYpos = templabelYpos;
    font = tempFont;
    // Anchor information
    cp5.addTextlabel("Info"+tagName)
       .setText("Position of tag"
               +"\nX: "+tempXpos+" (m)"
               +"\nY: "+tempYpos+" (m)")
       .setPosition(labelXpos,labelYpos)
       .setColorValue(c)
       .setFont(font)
       ;    
  }
  void Tag_show(double tempXpos, double tempYpos)
  {
    float tXpos = (float) tempXpos;
    float tYpos = (float) tempYpos;
    xpos = map(tXpos, 0, 10, 0, 600) + 150;
    ypos = map(tYpos, 0, 10, 0, 600) + 20;
    noStroke();
    fill(c);
    ellipseMode(CENTER);
    ellipse(xpos, ypos, 15, 15);

    cp5.getController("Info"+tagName).setStringValue("Position of tag"
                                                +"\nX: "+tXpos+" (m)"
                                                +"\nY: "+tYpos+" (m)")
                                                ;      
  }
  void hide_label()
  {
    cp5.getController("Info"+tagName).setVisible(false);
  }
  void show_label()
  {
    cp5.getController("Info"+tagName).setVisible(true);
  }
  
}
