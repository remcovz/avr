
// $Id: thermometer.pde 43 2011-05-05 11:07:41Z remcovz $
// Processing sourcecode


import processing.serial.*;
import processing.net.*; 
import cc.arduino.*;

Client myClient;
Arduino arduino;

int counter = 60;

void setup()
{
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  // change this for your own rrd server.
  myClient = new Client(this, "194.109.192.226", 23456);   
}

void draw()
{
  
  int tempVoltage = arduino.analogRead(0);
  float temp = (tempVoltage * .004882814);
  temp = (temp - .5) * 100;
  println(temp);
  
 if (myClient.available() > 0) { 
    byte[] myByte = myClient.readBytes();
    String myString = new String(myByte);
    println(myString);   
  } 
  
  counter++;
  
  if (counter > 60) {
     sendTemp(temp);
     counter = 0;
  }
  
  delay(1000);
  
}

void sendTemp(float temp)
{
  myClient.write("update temp.rrd N:" + temp + "\n");
}
