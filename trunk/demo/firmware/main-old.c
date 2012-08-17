#include <avr/io.h>
#include <util/delay.h>

#define LED1 PB4

int main(void)
{
    DDRB = 1 << LED1;           /* make the LED pin an output */
    for(;;){
        char i;
        for(i = 0; i < 10; i++){
            _delay_ms(10);  /* max is 262.14 ms / F_CPU in MHz */
        }
        PORTB ^= 1 << LED1;    /* toggle the LED */
    }
    return 0;               /* never reached */
}
