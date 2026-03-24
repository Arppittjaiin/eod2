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
    echo [1/3] Updating repository...
    git pull
) else (
    echo [SKIP] Git not found, skipping repository update.
)

echo.
echo [2/3] Syncing stock data...
:: Change to src directory if needed or run from root
python src\init.py
if %ERRORLEVEL% EQU 0 (
    where git >nul 2>nul
    if %ERRORLEVEL% EQU 0 (
        echo.
        echo [3/3] Pushing data to GitHub...
        git add .
        git commit -m "Auto-sync stock data: %date% %time%" && git push
    )
)

echo.
echo ==========================================
echo Process Completed.
echo ==========================================
pause
