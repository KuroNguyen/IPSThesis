import oscP5.*;
 
OscP5 oscP5;
String str;
Float k; 
void setup() {
  size(400, 400);
  frameRate(25);
  oscP5 = new OscP5(this, 12000);
  
}
 
void draw() {
  background(0);
  
}
 
void oscEvent(OscMessage m) {
  print(" addrpattern: "+m.addrPattern());
  println(" typetag: "+m.typetag());
  m.print();
  str = m.get(0).stringValue();
  print(str);
  k = float(str);
  print(k);
}  
