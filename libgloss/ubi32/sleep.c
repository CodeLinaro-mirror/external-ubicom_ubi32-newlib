#include "intsys.h"


unsigned int
sleep (unsigned int seconds)
{
   return INT_SYS (SYS_sleep, seconds, 0, 0);
}
