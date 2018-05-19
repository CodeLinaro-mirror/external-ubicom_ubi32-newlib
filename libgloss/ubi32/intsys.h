#include "syscall.h"

int __int_sys (int, void *, int, int);

#define INT_SYS(f,p1,p2,p3) __int_sys (f, (p1), (p2), (p3))
