OUTPUT_FORMAT("elf32-littleubicom32", "elf32-bigubicom32",
	      "elf32-littleubicom32")
OUTPUT_ARCH(ubi32)
ENTRY(_start)
SEARCH_DIR("install/ubi32-none-elf/lib");
/* Do we need any of these for elf?
   __DYNAMIC = 0;    */

PROGMEM_ORIGIN = 0x40000000;
PROGMEM_LENGTH = 0x00100000;
DATAMEM_ORIGIN = 0x40100000;
DATAMEM_LENGTH = 0x00100000;
FLASHRAM_ORIGIN = 0xb0000000;
FLASHRAM_LENGTH = 0x00400000;

MEMORY
{
  datamem (w) : ORIGIN = DATAMEM_ORIGIN, LENGTH = DATAMEM_LENGTH
  progmem (wx): ORIGIN = PROGMEM_ORIGIN, LENGTH = PROGMEM_LENGTH
  flashram (wx) : ORIGIN = FLASHRAM_ORIGIN, LENGTH = FLASHRAM_LENGTH
}
__progmem_start = PROGMEM_ORIGIN;
__progmem_length = PROGMEM_LENGTH;
__datamem_start = DATAMEM_ORIGIN;
__datamem_length = DATAMEM_LENGTH;
__flashram_start = FLASHRAM_ORIGIN;
__flashram_length = FLASHRAM_LENGTH;
SECTIONS
{
  .flram   : { *(.start) *(.flram) }  > flashram
  . = 0xc0000000;
  .text      :
  {
    *(.text)
    *(.text.*)
    *(.stub)
    /* .gnu.warning sections are handled specially by elf32.em.  */
    *(.gnu.warning)
    *(.gnu.linkonce.t*)
  }  > progmem =0
  .rel.text      :
    {
      *(.rel.text)
      *(.rel.text.*)
      *(.rel.gnu.linkonce.t*)
    }  > progmem
  .rela.text     :
    {
      *(.rela.text)
      *(.rela.text.*)
      *(.rela.gnu.linkonce.t*)
    }  > progmem
  .init          :
  {
    KEEP (*(.init))
  }  > datamem =0
  .plt      : { *(.plt)	}  > datamem
  .fini      :
  {
    KEEP (*(.fini))
  }  > datamem =0
  PROVIDE (__etext = .);
  PROVIDE (_etext = .);
  PROVIDE (etext = .);
  /* Adjust the address for the data segment.  We want to adjust up to
     the same address within the page on the next page up.  */
  . = 0x100000;
  /* Skip first word to ensure first data element can't end up having address
     0 in code (NULL pointer) */
  . = . + 4;
  .data    :
  {
    *(.data)
    *(.data.*)
    *(.gnu.linkonce.d*)
    SORT(CONSTRUCTORS)
  }  > datamem
  .data1   : { *(.data1) }  > datamem
  PROVIDE (___eh_frame_begin = .);
  .eh_frame   :
  {
    *(.eh_frame)
    LONG (0);
  }  > datamem
  PROVIDE (___eh_frame_end = .);
  .gcc_except_table : { *(.gcc_except_table) }  > datamem
  /* Read-only sections, placed in data space: */
  .interp     : { *(.interp) 	}  > datamem
  .hash          : { *(.hash)		}  > datamem
  .dynsym        : { *(.dynsym)		}  > datamem
  .dynstr        : { *(.dynstr)		}  > datamem
  .gnu.version   : { *(.gnu.version)	}  > datamem
  .gnu.version_d   : { *(.gnu.version_d)	}  > datamem
  .gnu.version_r   : { *(.gnu.version_r)	}  > datamem
  .rel.init      : { *(.rel.init)	}  > datamem
  .rela.init     : { *(.rela.init)	}  > datamem
  .rel.fini      : { *(.rel.fini)	}  > datamem
  .rela.fini     : { *(.rela.fini)	}  > datamem
  .rel.rodata    :
    {
      *(.rel.rodata)
      *(.rel.rodata.*)
      *(.rel.gnu.linkonce.r*)
    }  > datamem
  .rela.rodata   :
    {
      *(.rela.rodata)
      *(.rela.rodata.*)
      *(.rela.gnu.linkonce.r*)
    }  > datamem
  .rel.data      :
    {
      *(.rel.data)
      *(.rel.data.*)
      *(.rel.gnu.linkonce.d*)
    }  > datamem
  .rela.data     :
    {
      *(.rela.data)
      *(.rela.data.*)
      *(.rela.gnu.linkonce.d*)
    }  > datamem
  .rel.ctors     : { *(.rel.ctors)	}  > datamem
  .rela.ctors    : { *(.rela.ctors)	}  > datamem
  .rel.dtors     : { *(.rel.dtors)	}  > datamem
  .rela.dtors    : { *(.rela.dtors)	}  > datamem
  .rel.got       : { *(.rel.got)		}  > datamem
  .rela.got      : { *(.rela.got)		}  > datamem
  .rel.sdata     :
    {
      *(.rel.sdata)
      *(.rel.sdata.*)
      *(.rel.gnu.linkonce.s*)
    }  > datamem
  .rela.sdata     :
    {
      *(.rela.sdata)
      *(.rela.sdata.*)
      *(.rela.gnu.linkonce.s*)
    }  > datamem
  .rel.sbss      : { *(.rel.sbss)		}  > datamem
  .rela.sbss     : { *(.rela.sbss)	}  > datamem
  .rel.sdata2    : { *(.rel.sdata2)	}  > datamem
  .rela.sdata2   : { *(.rela.sdata2)	}  > datamem
  .rel.sbss2     : { *(.rel.sbss2)	}  > datamem
  .rela.sbss2    : { *(.rela.sbss2)	}  > datamem
  .rel.bss       : { *(.rel.bss)		}  > datamem
  .rela.bss      : { *(.rela.bss)		}  > datamem
  .rel.plt       : { *(.rel.plt)		}  > datamem
  .rela.plt      : { *(.rela.plt)		}  > datamem
  .rodata   : { *(.rodata) *(.rodata.*) *(.gnu.linkonce.r*) }  > datamem
  .rodata1   : { *(.rodata1) }  > datamem
  .sdata2   : { *(.sdata2) }  >datamem
  .sbss2   : { *(.sbss2) }  > datamem
  . = ALIGN(32 / 8);
  .ctors   :
  {
    . = ALIGN(32 / 8);
    ___ctors = .;
    LONG (-1)
    /* gcc uses crtbegin.o to find the start of
       the constructors, so we make sure it is
       first.  Because this is a wildcard, it
       doesn't matter if the user does not
       actually link against crtbegin.o; the
       linker won't look for a file to match a
       wildcard.  The wildcard also means that it
       doesn't matter which directory crtbegin.o
       is in.  */
    KEEP (*crtbegin.o(.ctors))
    /* We don't want to include the .ctor section from
       from the crtend.o file until after the sorted ctors.
       The .ctor section from the crtend file contains the
       end of ctors marker and it must be last */
    KEEP (*(EXCLUDE_FILE (*crtend.o ) .ctors))
    KEEP (*(SORT(.ctors.*)))
    KEEP (*(.ctors))
    LONG (0)
    __ctors_end = . ;
  }  > datamem
   .dtors         :
  {
    . = ALIGN(32 / 8);
    ___dtors = .;
    KEEP (*crtbegin.o(.dtors))
    KEEP (*(EXCLUDE_FILE (*crtend.o ) .dtors))
    KEEP (*(SORT(.dtors.*)))
    KEEP (*(.dtors))
    ___dtors_end = .;
  }  > datamem
  .got		  : { *(.got.plt) *(.got) }  > datamem
  .dynamic       : { *(.dynamic) }  > datamem
  /* We want the small data sections together, so single-instruction offsets
     can access them all, and initialized data all before uninitialized, so
     we can shorten the on-disk segment size.  */
  .sdata     :
  {
    *(.sdata)
    *(.sdata.*)
    *(.gnu.linkonce.s.*)
  }  > datamem
  _edata = .;
  PROVIDE (edata = .);
  __bss_start = .;
  .sbss      :
  {
    PROVIDE (__sbss_start = .);
    PROVIDE (___sbss_start = .);
    *(.dynsbss)
    *(.sbss)
    *(.sbss.*)
    *(.scommon)
    PROVIDE (__sbss_end = .);
    PROVIDE (___sbss_end = .);
  }  > datamem
  .bss       :
  {
   *(.dynbss)
   *(.bss)
   *(.bss.*)
   *(COMMON)
   /* Align here to ensure that the .bss section occupies space up to
      _end.  Align after .bss to ensure correct alignment even if the
      .bss section disappears because there are no input sections.  */
   . = ALIGN(32 / 8);
  }  > datamem
  . = ALIGN(32 / 8);
  _end = .;
  PROVIDE (end = .);
  /* Stabs debugging sections.  */
  .stab 0 : { *(.stab) }
  .stabstr 0 : { *(.stabstr) }
  .stab.excl 0 : { *(.stab.excl) }
  .stab.exclstr 0 : { *(.stab.exclstr) }
  .stab.index 0 : { *(.stab.index) }
  .stab.indexstr 0 : { *(.stab.indexstr) }
  .comment 0 : { *(.comment) }
  /* DWARF debug sections.
     Symbols in the DWARF debugging sections are relative to the beginning
     of the section so we begin them at 0.  */
  /* DWARF 1 */
  .debug          0 : { *(.debug) }
  .line           0 : { *(.line) }
  /* GNU DWARF 1 extensions */
  .debug_srcinfo  0 : { *(.debug_srcinfo) }
  .debug_sfnames  0 : { *(.debug_sfnames) }
  /* DWARF 1.1 and DWARF 2 */
  .debug_aranges  0 : { *(.debug_aranges) }
  .debug_pubnames 0 : { *(.debug_pubnames) }
  /* DWARF 2 */
  .debug_info     0 : { *(.debug_info) }
  .debug_abbrev   0 : { *(.debug_abbrev) }
  .debug_line     0 : { *(.debug_line) }
  .debug_frame    0 : { *(.debug_frame) }
  .debug_str      0 : { *(.debug_str) }
  .debug_loc      0 : { *(.debug_loc) }
  .debug_macinfo  0 : { *(.debug_macinfo) }
  /* SGI/MIPS DWARF 2 extensions */
  .debug_weaknames 0 : { *(.debug_weaknames) }
  .debug_funcnames 0 : { *(.debug_funcnames) }
  .debug_typenames 0 : { *(.debug_typenames) }
  .debug_varnames  0 : { *(.debug_varnames) }
  /* These must appear regardless of  .  */
  /* Define _heapsize on at the commandline using -Wl,--defsym,_heapsize=value   */
  /* if you want to make the heap smaller than the default, effectively limiting */
  /* how much memory can be allocated.                                           */
  .heap :
  {
    *(.heap)
    . = (DEFINED(_heapsize) ? (. + _heapsize) : 0x10c000);
    _heaplimit = .;
  }  > flashram
  /* Define _stacksize on at the commandline using -Wl,--defsym,_stacksize=value   */
  .stack :
  {
    . = (DEFINED(_stacksize) ? (. + _stacksize) : 0x10000);
     _stack = . ;
    *(.stack)
  }  > flashram
}
