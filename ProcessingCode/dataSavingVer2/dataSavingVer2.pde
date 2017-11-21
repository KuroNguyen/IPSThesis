import oscP5.*;
 
OscP5 oscP5;
Table table;
String realDistance = "150"; // Distance set up
String rxColum = "RX150";
Float estimatedRange; // Range data in float format
Float rxGain;
int i = 0; // Counting number
void setup() 
{
  size(400, 400);
  oscP5 = new OscP5(this, 12000);
  table = loadTable("Angle4m.csv", "header");
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
  estimatedRange = float(m.get(0).stringValue());
  rxGain = float(m.get(1).stringValue());
  println(estimatedRange);
  println(rxGain);
  if (i < table.getRowCount())
  {
    TableRow row = table.getRow(i);
    row.setFloat(realDistance, estimatedRange);
    row.setFloat(rxColum, rxGain);
    i++;
  }
  else
  {
    saveTable(table, "Angle4m.csv");
    print("done");
    exit();
  }
}
