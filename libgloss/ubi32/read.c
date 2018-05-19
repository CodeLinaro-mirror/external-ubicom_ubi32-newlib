#include <_ansi.h>
#include <sys/types.h>
#include <sys/stat.h>
#include "intsys.h"

int
read (int file,
       char *ptr,
       size_t len)
{
  return INT_SYS (SYS_read, file, ptr, len);
}
