@echo off
set /P ENV_NAME="conda env name: "

REM --- Initialize conda for this shell ---
call "%USERPROFILE%\anaconda3\Scripts\activate.bat"

echo.
echo === Checking if environment exists ===
conda info --envs | findstr /R /C:"\b%ENV_NAME%\b" >nul
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Environment "%ENV_NAME%" does not exist.
    echo Please run the setup script first.
    pause
    exit /b
)

echo.
echo === Activating conda environment: %ENV_NAME% ===
call conda activate %ENV_NAME%

echo.
echo === Confirming Python path ===
where python

echo.
echo === Launching JupyterLab ===
jupyter lab
