#include <_ansi.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "intsys.h"


int kill (int n, int m)
{
  return INT_SYS (SYS_exit, 0xdead, 0, 0);
}
