#include <_ansi.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "intsys.h"


int
fork ()
{
  return INT_SYS (SYS_fork, 0, 0, 0);
}
