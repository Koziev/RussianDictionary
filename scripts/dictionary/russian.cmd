@echo off

rem (c) by Elijah Koziev www.solarix.ru
rem The script builds the russian dictionary (lexicon + thesaurus + syntax analyzer), version 'PRO'
rem More info about dictionary compilation:
rem http://solarix.ru/for_developers/bootstrap/compile_dictionary.shtml

Call cleanup

IF DEFINED PROCESSOR_ARCHITEW6432 GOTO x64

..\..\exe\compiler -j=2 -optimize -dir=..\..\dictionary.src -outdir=..\..\bin-windows -ldsize=2000000 -save_paradigmas -save_prefix_entry_searcher -save_seeker -save_affixes -save_lemmatizer ..\..\dictionary.src\version-pro ..\..\dictionary.src\dictionary -file=..\..\dictionary.src\russian-language-only.sol ..\..\dictionary.src\shared-resources ..\..\dictionary.src\russian-lexicon ..\..\dictionary.src\russian-stat ..\..\dictionary.src\common-syntax  ..\..\dictionary.src\russian-syntax ..\..\dictionary.src\russian-thesaurus ..\..\dictionary.src\lemm_model.files ..\..\dictionary.src\dictionary-russian ..\..\dictionary.src\common_dictionary_xml

GOTO End

:x64
..\..\exe64\compiler -j=2 -optimize -dir=..\..\dictionary.src -outdir=..\..\bin-windows64 -ldsize=2000000 -save_paradigmas -save_prefix_entry_searcher -save_seeker -save_affixes -save_lemmatizer ..\..\dictionary.src\version-pro ..\..\dictionary.src\dictionary -file=..\..\dictionary.src\russian-language-only.sol ..\..\dictionary.src\shared-resources ..\..\dictionary.src\russian-lexicon ..\..\dictionary.src\russian-stat ..\..\dictionary.src\common-syntax  ..\..\dictionary.src\russian-syntax ..\..\dictionary.src\russian-thesaurus ..\..\dictionary.src\lemm_model.files ..\..\dictionary.src\dictionary-russian ..\..\dictionary.src\common_dictionary_xml

:End
 

Call post-compile.cmd
