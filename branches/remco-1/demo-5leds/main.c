#include <avr/io.h>
#include <util/delay.h>

#define LED1 PB4 
#define LED2 PB3
#define LED3 PB0
#define LED4 PB1
#define LED5 PB2

void delay ( int ms )
{
    while ( ms-- > 0 ) _delay_ms( 1 );
}

int main(void)
{
    DDRB = 1 << LED1 | 1 << LED2 | 1 << LED3 | 1 << LED4 | 1 << LED5;
 
    while( 1 ) {
      PORTB = 1 << LED1 | 0 << LED2 | 0 << LED3 | 0 << LED4 | 0 << LED5;
      delay ( 50 );
      PORTB = 0 << LED1 | 1 << LED2 | 0 << LED3 | 0 << LED4 | 0 << LED5;
      delay ( 50 );
      PORTB = 0 << LED1 | 0 << LED2 | 1 << LED3 | 0 << LED4 | 0 << LED5;
      delay ( 50 ); 
      PORTB = 0 << LED1 | 0 << LED2 | 0 << LED3 | 1 << LED4 | 0 << LED5;
      delay ( 50 );
      PORTB = 0 << LED1 | 0 << LED2 | 0 << LED3 | 0 << LED4 | 1 << LED5;
      delay ( 50 );
    }
    
    return 0;               /* never reached */
}
