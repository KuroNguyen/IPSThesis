class point_loca
{
  color c;
  float xpos;
  float ypos;
  String textField;
  String textCaption;
  String labelName;
  String labelText;
  PFont font; 
  point_loca(color tempC, float tempXpos, float tempYpos, String tempTextField, String tempTextCaption, String tempLabelName, String tempLabelText, PFont tempFont)
  {
    c = tempC;
    xpos = tempXpos;
    ypos = tempYpos;
    textField = tempTextField;
    textCaption = tempTextCaption;
    labelName = tempLabelName;
    labelText = tempLabelText;
    font = tempFont;
    // Textfield for X
    cp5.addTextfield("X"+textField)
       .setPosition(tempXpos,tempYpos)
       .setSize(80,30)
       .setFont(font)
       .setFocus(true)
       .setColor(c)
       ; 
    cp5.getController("X"+textField).getCaptionLabel().setFont(font);
    cp5.getController("X"+textField).getCaptionLabel().setColor(c);
    cp5.getController("X"+textField).getCaptionLabel().setText("X of " + textCaption);
    // Parameter label
    cp5.addTextlabel("paraLabelA"+labelName)
       .setText("( m )")
       .setPosition(tempXpos + 90,tempYpos)
       .setColorValue(c)
       .setFont(font)
       ;
    // Label for X
    cp5.addTextlabel("xLabel"+labelName)
       .setText("X"+labelText+": ")
       .setPosition(tempXpos,tempYpos + 100)
       .setColorValue(c)
       .setFont(font)
       ;
            
    // Textfield for Y
    cp5.addTextfield("Y"+textField)
       .setPosition(tempXpos+170,tempYpos)
       .setSize(80,30)
       .setFont(font)
       .setFocus(true)
       .setColor(c)
       ; 
    cp5.getController("Y"+textField).getCaptionLabel().setFont(font);
    cp5.getController("Y"+textField).getCaptionLabel().setColor(c);
    cp5.getController("Y"+textField).getCaptionLabel().setText("Y of " + textCaption);
    // Parameter label
    cp5.addTextlabel("paraLabelB"+labelName)
       .setText("( m )")
       .setPosition(tempXpos + 170 + 90 ,tempYpos)
       .setColorValue(c)
       .setFont(font)
       ;
    // Label for Y
    cp5.addTextlabel("yLabel"+labelName)
       .setText("Y"+labelText+": ")
       .setPosition(tempXpos+170,tempYpos + 100)
       .setColorValue(c)
       .setFont(font)
       ;
       
  }
  void setTextX(String text)
  {
    cp5.getController("xLabel"+labelName).getValueLabel().setText(text);
  }
  void setTextY(String text)
  {
    cp5.getController("yLabel"+labelName).getValueLabel().setText(text);
  }
  void turnOff()
  {
    cp5.getController("X"+textField).setVisible(false);
    cp5.getController("Y"+textField).setVisible(false);
    cp5.getController("xLabel"+labelName).setVisible(false);
    cp5.getController("yLabel"+labelName).setVisible(false);
    cp5.getController("paraLabelA"+labelName).setVisible(false);
    cp5.getController("paraLabelB"+labelName).setVisible(false);
  }
  void turnOn()
  {
    cp5.getController("X"+textField).setVisible(true);
    cp5.getController("Y"+textField).setVisible(true);
    cp5.getController("xLabel"+labelName).setVisible(true);
    cp5.getController("yLabel"+labelName).setVisible(true);
    cp5.getController("paraLabelA"+labelName).setVisible(true);
    cp5.getController("paraLabelB"+labelName).setVisible(true);
  }
}
