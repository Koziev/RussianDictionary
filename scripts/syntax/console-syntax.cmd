rem Запуск консольного отладчика синтаксического парсера
rem SYNTAX.EXE manual page: http://www.solarix.ru/for_developers/exercise/syntax-analysis.shtml

IF DEFINED PROCESSOR_ARCHITEW6432 GOTO x64

..\..\exe\Syntax.exe -dictdir ..\..\bin-windows -lazy_lexicon -disallow_incomplete -syntax -maxalt 30

GOTO End

:x64

..\..\exe64\Syntax.exe -dictdir ..\..\bin-windows64 -lazy_lexicon -disallow_incomplete -syntax -maxalt 30

:End

