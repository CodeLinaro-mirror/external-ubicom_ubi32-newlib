#include <_ansi.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "intsys.h"


int
wait (statusp)
     int *statusp;
{
  return INT_SYS (SYS_wait, 0, 0, 0);
}
