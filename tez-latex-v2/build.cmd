@echo off
setlocal
rem Tectonic derleyici yolu. Oncelik: PATH -> kalici kurulum -> codex eklenti onbellegi.
set "TECTONIC="
for /f "delims=" %%i in ('where tectonic.exe 2^>nul') do if not defined TECTONIC set "TECTONIC=%%i"
if not defined TECTONIC if exist "%USERPROFILE%\.local\bin\tectonic.exe" set "TECTONIC=%USERPROFILE%\.local\bin\tectonic.exe"
if not defined TECTONIC if exist "%USERPROFILE%\.codex\.tmp\bundled-marketplaces\openai-bundled\plugins\latex\bin\tectonic.exe" set "TECTONIC=%USERPROFILE%\.codex\.tmp\bundled-marketplaces\openai-bundled\plugins\latex\bin\tectonic.exe"

if not defined TECTONIC (
  echo Tectonic bulunamadi.
  echo Kurulum: tectonic.exe dosyasini "%USERPROFILE%\.local\bin\" klasorune kopyalayin.
  exit /b 1
)

echo Tectonic: %TECTONIC%
if not exist build mkdir build
"%TECTONIC%" main.tex --outdir build --keep-logs --keep-intermediates
exit /b %ERRORLEVEL%
