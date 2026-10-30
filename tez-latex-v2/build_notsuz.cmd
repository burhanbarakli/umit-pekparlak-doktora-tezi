@echo off
setlocal
rem Teslim surumu: \umitnot kutulari kapali. Cikti build_notsuz\main_notsuz.pdf
set "TECTONIC="
for /f "delims=" %%i in ('where tectonic.exe 2^>nul') do if not defined TECTONIC set "TECTONIC=%%i"
if not defined TECTONIC if exist "%USERPROFILE%\.local\bin\tectonic.exe" set "TECTONIC=%USERPROFILE%\.local\bin\tectonic.exe"

if not defined TECTONIC (
  echo Tectonic bulunamadi.
  echo Kurulum: tectonic.exe dosyasini "%USERPROFILE%\.local\bin\" klasorune kopyalayin.
  exit /b 1
)

echo Tectonic: %TECTONIC%
if not exist build_notsuz mkdir build_notsuz
"%TECTONIC%" main_notsuz.tex --outdir build_notsuz --keep-logs --keep-intermediates
exit /b %ERRORLEVEL%
