import oscP5.*;
 
OscP5 oscP5;
Table table;
String realDistance = "1m";
void setup() 
{
  size(400, 400);
  oscP5 = new OscP5(this, 12000);
  table = loadTable("testcsv.csv", "header");
  println(table.getRowCount() + " total rows in table");
}

void draw()
{
}

void oscEvent(OscMessage m)
{
  print(" addrpattern: "+m.addrPattern());
  println(" typetag: "+m.typetag());
  m.print();
  print(float(m.get(0)));
}
