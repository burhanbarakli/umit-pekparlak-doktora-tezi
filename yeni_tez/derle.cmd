@echo off
rem Tezi SAU FBE sablonuyla derler: LuaLaTeX + BibTeX + LuaLaTeX x2.
rem Kullanim:  .\derle.cmd          -> tez.pdf (teslim surumu, notsuz)
rem            .\derle.cmd notlu    -> tez_notlu.pdf (UMIT ABI ICIN NOT kutulari acik)
setlocal
set "MIKTEX=%LOCALAPPDATA%\Programs\MiKTeX\miktex\bin\x64"
set "PATH=%MIKTEX%;%PATH%"
cd /d "%~dp0"
set "JOB=tez"
if /i "%~1"=="notlu" set "JOB=tez_notlu"
lualatex -interaction=nonstopmode %JOB%.tex >nul
bibtex %JOB% >nul
lualatex -interaction=nonstopmode %JOB%.tex >nul
lualatex -interaction=nonstopmode %JOB%.tex >nul
findstr /c:"Output written" %JOB%.log
findstr /b /c:"!" %JOB%.log
findstr /c:"undefined" %JOB%.log
endlocal
