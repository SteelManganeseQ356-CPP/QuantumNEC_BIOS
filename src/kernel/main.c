#include <Quantum-OS/Quantum-OS.h>
int magicTime = QUANTUMOS_MAGICTIME;
char EnterKernelMessage[] = "Enter Quantum-OS Kernel -> OK";                     // .data
char WelcomeMessage[] = "Quantum-OS System Build-number -- 10000" ;              // .data
char buffer[1024];                                                               // .bss
void kernelInit(void)
{
    char* video = (char*)0xb8640;
    for (int i = 0; i < sizeof(EnterKernelMessage); ++i)
    {
        video[i * 2] = EnterKernelMessage[i];
    }

    video = (char*)0xb8780;
    for (int i = 0; i < sizeof(WelcomeMessage); ++i)
    {
        video[i * 2] = WelcomeMessage[i];
    }

    /* 提示进入内核，打印字符串 */

    
}