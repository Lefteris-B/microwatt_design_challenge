/* sw/hello.c — very small baremetal UART test (adjust UART_BASE) */
#define UART_BASE 0x10000000
#define UART_THR  (UART_BASE + 0x0)
static inline void putc(char c) { *((volatile unsigned int*)UART_THR) = (unsigned int)c; }
int main(void) {
    const char *s = "Hello MicroWatt-LX!\n";
    for (const char *p = s; *p; ++p) putc(*p);
    for (;;) __asm__("wfi");
    return 0;
}
