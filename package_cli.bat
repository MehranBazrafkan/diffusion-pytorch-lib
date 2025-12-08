@echo off
setlocal enabledelayedexpansion

:menu
cls
echo =========================
echo Python Package CLI
echo =========================
echo 1. Clean old builds
echo 2. Build package
echo 3. Upload to PyPI
echo 4. Install package locally
echo 5. Do everything automatically
echo 0. Exit
echo =========================
set /p choice="Select an option: "

if "%choice%"=="1" goto clean
if "%choice%"=="2" goto build
if "%choice%"=="3" goto upload
if "%choice%"=="4" goto install
if "%choice%"=="5" goto all
if "%choice%"=="0" exit

echo Invalid choice, try again.
pause
goto menu

:clean
echo Cleaning old builds...
if exist dist rmdir /s /q dist
if exist build rmdir /s /q build
for /d %%d in (*.egg-info) do rmdir /s /q "%%d"
echo Done cleaning.
pause
goto menu

:build
echo Building package...
python -m pip install --upgrade build
python -m build
echo Done building.
pause
goto menu

:upload
echo Uploading package to PyPI...
python -m pip install --upgrade twine
python -m twine upload dist/*
echo Done uploading.
pause
goto menu

:install
echo Installing package locally...
:: Replace 'your-library' with your actual package name from pyproject.toml
pip install --upgrade your-library
echo Done installing.
pause
goto menu

:all
call :clean
call :build
call :upload
call :install
goto menu
