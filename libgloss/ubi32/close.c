#include <_ansi.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "intsys.h"


int
close (int file)
{
  return INT_SYS (SYS_close, file, 0, 0);
}
