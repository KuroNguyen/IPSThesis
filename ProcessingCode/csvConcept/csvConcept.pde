Table table;
String realDistance = "1m";
void setup()
{
  table = loadTable("testcsv.csv", "header");
  println(table.getRowCount() + " total rows in table");
  for (int i=0; i<table.getRowCount(); i++) 
  {
    TableRow row = table.getRow(i);
    row.setFloat(realDistance,10.3);
  }
  saveTable(table, "testcsv.csv");
}
