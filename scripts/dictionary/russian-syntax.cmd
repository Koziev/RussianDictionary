@echo off
rem (c) by Elijah Koziev www.solarix.ru
rem The script recompiles the syntax rules for Russian language, version 'PRO'
rem More info about dictionary compilation:
rem http://solarix.ru/for_developers/bootstrap/compile_dictionary.shtml

IF DEFINED PROCESSOR_ARCHITEW6432 GOTO x64

..\..\exe\compiler -recompile_syntax -j=2 -optimize -dir=..\..\dictionary.src -outdir=..\..\bin-windows ..\..\dictionary.src\common-syntax  ..\..\dictionary.src\russian-syntax ..\..\dictionary.src\common_dictionary_xml

GOTO End

:x64
..\..\exe64\compiler -recompile_syntax -j=2 -optimize -dir=..\..\dictionary.src -outdir=..\..\bin-windows64 ..\..\dictionary.src\common-syntax  ..\..\dictionary.src\russian-syntax ..\..\dictionary.src\common_dictionary_xml

:End

Call post-compile.cmd
