#include <stdlib.h>
#include "intsys.h"


void
abort(void)
{
  return INT_SYS (SYS_kill, -1, 0, 0);
}
