import oscP5.*;
 
OscP5 oscP5;
Table table;
String realDistance = "1m"; // Distance set up 
Float estimatedRange; // Range data in float format
int i = 0; // Counting number
void setup() 
{
  size(400, 400);
  oscP5 = new OscP5(this, 12000);
  table = loadTable("real&estimate.csv", "header");
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
  print(estimatedRange);
  if (i < table.getRowCount())
  {
    TableRow row = table.getRow(i);
    row.setFloat(realDistance, estimatedRange);
    i++;
  }
  else
  {
    saveTable(table, "real&estimate.csv");
    print("done");
    exit();
  }
}
