/*
  Row-Column Scanning an 8x8 LED matrix
  
 This example works for the Lumex  LDM-24488NI Matrix. See 
 http://sigma.octopart.com/140413/datasheet/Lumex-LDM-24488NI.pdf
 for the pin connections
 
 For other LED cathode column matrixes, you should only need to change 
 the pin numbers in the row[] and col[] arrays
 
 rows are the anodes
 cols are the cathodes
 ---------
 
 Pin numbers:
 Matrix:
 * Digital pins 2 through 13,
 * analog pins 2 through 5 used as digital 16 through 19
 
 This example code is in the public domain.
 
 */

#define SMILEY { \
    {0, 0, 1, 1, 1, 1, 0, 0}, \
    {0, 1, 0, 0, 0, 0, 1, 0}, \
    {1, 0, 1, 0, 0, 1, 0, 1}, \
    {1, 0, 0, 0, 0, 0, 0, 1}, \
    {1, 0, 1, 0, 0, 1, 0, 1}, \
    {1, 0, 0, 1, 1, 0, 0, 1}, \
    {0, 1, 0, 0, 0, 0, 1, 0}, \
    {0, 0, 1, 1, 1, 1, 0, 0}  \
 }

#define FROWNEY { \
    {0, 0, 1, 1, 1, 1, 0, 0}, \
    {0, 1, 0, 0, 0, 0, 1, 0}, \
    {1, 0, 1, 0, 0, 1, 0, 1}, \
    {1, 0, 0, 0, 0, 0, 0, 1}, \
    {1, 0, 0, 1, 1, 0, 0, 1}, \
    {1, 0, 1, 0, 0, 1, 0, 1}, \
    {0, 1, 0, 0, 0, 0, 1, 0}, \
    {0, 0, 1, 1, 1, 1, 0, 0}  \
}
 
#define SPACE { \
    {0, 0, 0, 0, 0, 0, 0, 0},  \
    {0, 0, 0, 0, 0, 0, 0, 0}, \
    {0, 0, 0, 0, 0, 0, 0, 0}, \
    {0, 0, 0, 0, 0, 0, 0, 0}, \
    {0, 0, 0, 0, 0, 0, 0, 0}, \
    {0, 0, 0, 0, 0, 0, 0, 0}, \
    {0, 0, 0, 0, 0, 0, 0, 0}, \
    {0, 0, 0, 0, 0, 0, 0, 0} \
}

#define H { \
    {0, 1, 0, 0, 0, 0, 1, 0}, \
    {0, 1, 0, 0, 0, 0, 1, 0}, \
    {0, 1, 0, 0, 0, 0, 1, 0}, \
    {0, 1, 1, 1, 1, 1, 1, 0}, \
    {0, 1, 0, 0, 0, 0, 1, 0}, \
    {0, 1, 0, 0, 0, 0, 1, 0}, \
    {0, 1, 0, 0, 0, 0, 1, 0}, \
    {0, 1, 0, 0, 0, 0, 1, 0}  \
}

#define E  { \
    {0, 1, 1, 1, 1, 1, 1, 0}, \
    {0, 1, 0, 0, 0, 0, 0, 0}, \
    {0, 1, 0, 0, 0, 0, 0, 0}, \
    {0, 1, 1, 1, 1, 1, 1, 0}, \
    {0, 1, 0, 0, 0, 0, 0, 0}, \
    {0, 1, 0, 0, 0, 0, 0, 0}, \
    {0, 1, 0, 0, 0, 0, 0, 0}, \
    {0, 1, 1, 1, 1, 1, 1, 0}  \
}

#define L { \
    {0, 1, 0, 0, 0, 0, 0, 0}, \
    {0, 1, 0, 0, 0, 0, 0, 0}, \
    {0, 1, 0, 0, 0, 0, 0, 0}, \
    {0, 1, 0, 0, 0, 0, 0, 0}, \
    {0, 1, 0, 0, 0, 0, 0, 0}, \
    {0, 1, 0, 0, 0, 0, 0, 0}, \
    {0, 1, 0, 0, 0, 0, 0, 0}, \
    {0, 1, 1, 1, 1, 1, 1, 0}  \
}

#define O { \
    {0, 0, 0, 1, 1, 0, 0, 0}, \
    {0, 0, 1, 0, 0, 1, 0, 0}, \
    {0, 1, 0, 0, 0, 0, 1, 0}, \
    {0, 1, 0, 0, 0, 0, 1, 0}, \
    {0, 1, 0, 0, 0, 0, 1, 0}, \
    {0, 1, 0, 0, 0, 0, 1, 0}, \
    {0, 0, 1, 0, 0, 1, 0, 0}, \
    {0, 0, 0, 1, 1, 0, 0, 0}  \
}

// 2-dimensional array of row pin numbers:
const int row[8] = { 2, 7, 19, 5, 13, 18, 12, 16 };

// 2-dimensional array of column pin numbers:
const int col[8] = { 6, 11, 10, 3, 17, 4, 8, 9  };

// 2-dimensional array of pixels:
int pixels[8][8];           

const int numPatterns = 8;
byte patterns[numPatterns][8][8] = {
  H,E,L,L,O,SPACE,SMILEY,FROWNEY
};

//const int numPatterns = 2;
//byte patterns[numPatterns][8][8] = {
//  SMILEY,FROWNEY
//};

int pattern = 0;

void setup() {
  // initialize the I/O pins as outputs:
  // iterate over the pins:
  for (int thisPin = 0; thisPin < 8; thisPin++) {
    // initialize the output pins:
    pinMode(col[thisPin], OUTPUT); 
    pinMode(row[thisPin], OUTPUT);  
    // take the col pins (i.e. the cathodes) high to ensure that
    // the LEDS are off: 
    digitalWrite(col[thisPin], HIGH);    
  }

  // initialize the pixel matrix:
  for (int x = 0; x < 8; x++) {
    for (int y = 0; y < 8; y++) {
      pixels[x][y] = HIGH;
    }
  }  
}

void loop() {
  pattern = ++pattern % numPatterns;
  setPattern(pattern);
  
  // show pattern 100 times before moving on to next.
  for (int show = 0; show < 100; show++) {
    showpattern();
  }  
}

void showpattern() {
  for (int x = 0; x < 8; x++) {
    for (int y = 0; y < 8; y++) {

      if (pixels[x][y] == 1) {
        // turn on LED
        digitalWrite(row[x], HIGH);
        digitalWrite(col[y], LOW);
        delayMicroseconds(100);
      }
      // turn off LED
      digitalWrite(row[x], LOW);
      digitalWrite(col[y], HIGH);
      delayMicroseconds(100);
    }
  }
}
  
void setPattern(int pattern) {
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      pixels[i][j] = patterns[pattern][i][j];
    }
  }
}

