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
       .setSize(50,20)
       .setFont(font)
       .setFocus(true)
       .setColor(c)
       ; 
    cp5.getController("X"+textField).getCaptionLabel().setFont(font);
    cp5.getController("X"+textField).getCaptionLabel().setColor(c);
    cp5.getController("X"+textField).getCaptionLabel().setText("X of " + textCaption);
    // Label for X
    cp5.addTextlabel("xLabel"+labelName)
       .setText("X"+labelText+": ")
       .setPosition(tempXpos,tempYpos + 100)
       .setColorValue(0xffffff00)
       .setFont(font)
       ;
    
    // Textfield for Y
    cp5.addTextfield("Y"+textField)
       .setPosition(tempXpos+120,tempYpos)
       .setSize(50,20)
       .setFont(font)
       .setFocus(true)
       .setColor(c)
       ; 
    cp5.getController("Y"+textField).getCaptionLabel().setFont(font);
    cp5.getController("Y"+textField).getCaptionLabel().setColor(c);
    cp5.getController("Y"+textField).getCaptionLabel().setText("Y of " + textCaption);
    // Label for Y
    cp5.addTextlabel("yLabel"+labelName)
       .setText("Y"+labelText+": ")
       .setPosition(tempXpos+120,tempYpos + 100)
       .setColorValue(0xffffff00)
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
}
