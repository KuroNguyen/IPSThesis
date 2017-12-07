/*---------------------------------------------------------------------------------------------

  Open Sound Control (OSC) library for the ESP8266/ESP32

  Example for sending messages from the ESP8266/ESP32 to a remote computer
  The example is sending "hello, osc." to the address "/test".

  This example code is in the public domain.

--------------------------------------------------------------------------------------------- */
#if defined(ESP8266)
#include <ESP8266WiFi.h>
#else
#include <WiFi.h>
#endif
#include <WiFiUdp.h>
#include <OSCMessage.h>
//////////////
//char data[10];
//////////////
const char *ssid = "DWM1000";          // your network SSID (name)
const char *pass = "HOILAMGI";                    // your network password
String str;
char rangeValue[7];
char rxValue[8];
//boolean stringExceed = false;
//int k; //State for sending message
WiFiUDP Udp;                                // A UDP instance to let us send and receive packets over UDP
const IPAddress outIp(192,168,0,3);        // remote IP of your computer
const unsigned int outPort = 12000;          // remote port to receive OSC
const unsigned int localPort = 8888;        // local port to listen for OSC packets (actually not used for sending)

void setup() {
    Serial.begin(115200);

    // Connect to WiFi network
//    Serial.println();
//    Serial.println();
//    Serial.print("Connecting to ");
//    Serial.println(ssid);
    WiFi.begin(ssid, pass);

    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }
    Serial.println("");

    Serial.println("WiFi connected");
    Serial.println("IP address: ");
    Serial.println(WiFi.localIP());
    Serial.println("Starting UDP");
    Udp.begin(localPort);
    Serial.print("Local port: ");
#ifdef ESP32
    Serial.println(localPort);
#else
    Serial.println(Udp.localPort());
#endif
    delay(5000);
}

void loop() 
{
  //Receive serial data
  if (Serial.available())
  {
    while (Serial.available())
    {
      str = Serial.readStringUntil('\n');
    }
  }
  if (str != "")
  {
    //String Process
    int i=0;
    int b=0;
    for (i;i<str.indexOf('-');i++)
    {
      rangeValue[i] = str.charAt(i);
    }
    rangeValue[i] = '\0'; //End of string array
    i++;
    for (i; i< str.length();i++)
    {
      rxValue[b] = str.charAt(i);
      b++;
    }
    rxValue[b] = '\0';
    //End string process
    //Initialize OSC message
//    if (str.charAt(0) == '1')
//    {
//      OSCMessage msg("/Anchor1");
//      msg.add(rangeValue);
//      msg.add(rxValue);
//      Udp.beginPacket(outIp, outPort);
//      msg.send(Udp);
//      Udp.endPacket();
//      msg.empty();
//    }    
//    else if(str.charAt(0) == '2')
//    {
//      OSCMessage msg("/Anchor2");
//      msg.add(rangeValue);
//      msg.add(rxValue);
//      Udp.beginPacket(outIp, outPort);
//      msg.send(Udp);
//      Udp.endPacket();
//      msg.empty();
//    }          
//    else
//    { 
//      OSCMessage msg("/Anchor3");
//      //Value sending
//      msg.add(rangeValue);
//      msg.add(rxValue);
//      Udp.beginPacket(outIp, outPort);
//      msg.send(Udp);
//      Udp.endPacket();
//      msg.empty();
//    }    
      OSCMessage msg("/Anchor2");
      msg.add(rangeValue);
      msg.add(rxValue);
      Udp.beginPacket(outIp, outPort);
      msg.send(Udp);
      Udp.endPacket();
      msg.empty();
  }
}      

