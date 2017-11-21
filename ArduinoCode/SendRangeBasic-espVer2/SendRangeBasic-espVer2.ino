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
const char *ssid = "KuroThesis";          // your network SSID (name)
const char *pass = "HOILAMGI";                    // your network password
String str;
char rangeValue1[7]; // Distance to Anchor1
//char rxValue[7];
char rangeValue2[7]; // Distance to Anchor2
//char rxValue[7];
char rangeValue3[7]; // Distance to Anchor3
//char rxValue[7];
boolean receiveState = false; //false if receive distance from anchor1, true if receive distance from anchor3 
int i; //Counting variable of osc string message
int b; //Counting variable of string char
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
    // Add range value of anchor1 
    if (str.charAt(0) == '1')
    {
      receiveState = false;
      for (i = 0; i<str.length();i++)
      {
        rangeValue1[i] = str.charAt(i+1);                
      }
      rangeValue1[i] = '\0'; //Add null char for char array
    }
    // Add range value of anchor2
    else if (str.charAt(0) == '2')
    {
      for (i = 0; i<str.length();i++)
      {
        rangeValue2[i] = str.charAt(i+1);                
      }
      rangeValue2[i] = '\0'; //Add null char for char array
    }
    // Add range value of anchor3
    else 
    {
      receiveState = true; // Receive enough 3 distance value
      for (i = 0; i<str.length();i++)
      {
        rangeValue3[i] = str.charAt(i+1);                
      }
      rangeValue3[i] = '\0'; //Add null char for char array
    }
  }
  if (receiveState)
  {
    //Create OSC message 
    OSCMessage msg("/Anchor");
    msg.add(rangeValue1);
    msg.add(rangeValue2);
    msg.add(rangeValue3);
    Udp.beginPacket(outIp, outPort);
    msg.send(Udp);
    Udp.endPacket();
    msg.empty();
  }
}      

