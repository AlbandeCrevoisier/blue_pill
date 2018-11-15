#include <stdint.h>

#define GPIOA_CRL (*(volatile uint32_t *) 0x40010800)
#define GPIOA_BSRR (*(volatile uint32_t *) 0x40010810)
#define RCC_APB2ENR (*(volatile uint32_t *) 0x40021018)

#define SET(x) (1 << x)
#define CLEAR(x) (~(1 << x))

void led_init(void);
void led_on(void);

void
led_init(void)
{
	/* enable clock */
	RCC_APB2ENR = SET(2);
	/* push-pull output mode */
	GPIOA_CRL = 0x0101;
	led_on();
}

void
led_on(void)
{
	GPIOA_BSRR = SET(13);
}
