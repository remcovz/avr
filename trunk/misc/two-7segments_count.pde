
//Pin connected to ST_CP of 74HC595
int latchPin = 8;
//Pin connected to SH_CP of 74HC595
int clockPin = 12;
////Pin connected to DS of 74HC595
int dataPin = 11;

// common anode, count bits for leds that needs to be off (including digital po
int).
// A = 1, B = 2, C = 4, D = 8, E = 16, F = 32, G = 64, DP = 128
int ledset[] = { 192, 249, 164, 176, 153, 146, 130, 248, 128, 144 };

void setup() {
  //set pins to output because they are addressed in the main loop
  pinMode(latchPin, OUTPUT);
  pinMode(clockPin, OUTPUT);
  pinMode(dataPin, OUTPUT);
  Serial.begin(9600); 

}

void loop() {
   for (int a = 0; a < 10; a++) {
    Serial.println(a);
    int segment1 = ledset[a];
    int b = 10 - a;
    if (b == 10) { 
      b = 0; 
    }
    int segment2 = ledset[b];
    
    //ground latchPin and hold low for as long as you are transmitting
    digitalWrite(latchPin, LOW);
    shiftOut(dataPin, clockPin, MSBFIRST, segment1);   
    shiftOut(dataPin, clockPin, MSBFIRST, segment2);
    //return the latch pin high to signal chip that it 
    //no longer needs to listen for information
    digitalWrite(latchPin, HIGH);
    delay(500);
  }
}
