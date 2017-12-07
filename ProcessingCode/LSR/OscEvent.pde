// OSC receive event
void oscEvent(OscMessage m)
{
  // Receive from anchor 1
  if (m.addrPattern().equals("/Anchor1"))
  {
      String str = m.get(0).stringValue();
      Range1 = float(str);
      println("ANCHOR 1: "+Range1);
      String rx = m.get(1).stringValue();
      Rx1 = float(rx);
      println("ANCHOR 1: "+Rx1);
  }
  // Receive from anchor 2
  else if (m.addrPattern().equals("/Anchor2"))
  {
      String str = m.get(0).stringValue();
      Range2 = float(str);
      println("ANCHOR 2: "+Range2);
      String rx = m.get(1).stringValue(); 
      Rx2 = float(rx);
      println("ANCHOR 2: "+Rx2);
  }
  // Receive from anchor 3
  else if(m.addrPattern().equals("/Anchor3"))
  {  
      String str = m.get(0).stringValue();
      Range3 = float(str);
      println("ANCHOR 3: "+Range3);
      String rx = m.get(1).stringValue();
      Rx3 = float(rx);
      println("ANCHOR 3: "+Rx3);
  }
}
