@echo off
:: Batch script to sync latest NSE stock data for EOD2
:: This script performs a git pull to update the repository and then runs the data sync script.

setlocal
cd /d "%~dp0"

echo ==========================================
echo       EOD2 - NSE Stock Data Sync
echo ==========================================
echo.

:: Check if git is installed and update repo
where git >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo [1/2] Updating repository...
    git pull
) else (
    echo [SKIP] Git not found, skipping repository update.
)

echo.
echo [2/2] Syncing stock data...
:: Change to src directory if needed or run from root
python src\init.py

echo.
echo ==========================================
echo Process Completed.
echo ==========================================
pause
