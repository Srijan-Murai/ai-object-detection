@echo off
title Conda Manager

REM === Initialize Conda for this shell (works from any CMD) ===
call "%USERPROFILE%\anaconda3\Scripts\activate.bat"

echo.
echo ===============================
echo   Conda Environment Manager
echo ===============================
echo.
echo 1. Create environment + register kernel + launch JupyterLab
echo 2. Activate environment + launch JupyterLab
echo 3. Delete environment AND its Jupyter kernel
echo 4. Exit
echo.

set /P CHOICE="Select an option (1-4): "

if "%CHOICE%"=="1" goto SETUP
if "%CHOICE%"=="2" goto RUN
if "%CHOICE%"=="3" goto DELETE
if "%CHOICE%"=="4" goto END

echo Invalid option.
pause
goto END

:SETUP
echo.
set /P ENV_NAME="Conda env name to CREATE: "

echo.
echo === Creating conda environment: %ENV_NAME% ===
call conda create -y -n %ENV_NAME% python=3.10.19

echo.
echo === Activating conda environment ===
call conda activate %ENV_NAME%

echo.
echo === Upgrading pip ===
python -m pip install --upgrade pip

echo.
echo === Installing minimal Jupyter packages ===
pip install ipykernel jupyterlab

echo.
echo === Registering Jupyter kernel ===
python -m ipykernel install --user --name=%ENV_NAME% --display-name=%ENV_NAME%

echo.
echo === Launching JupyterLab ===
jupyter lab
goto END

:RUN
echo.
jupyter kernelspec list

echo.
set /P ENV_NAME="Conda env name to ACTIVATE: "

echo.
echo === Activating conda environment ===
call conda activate %ENV_NAME%

echo.
echo === Launching JupyterLab ===
jupyter lab
goto END

:DELETE
echo.
echo === Installed Jupyter Kernels (ALL environments) ===
echo.
jupyter kernelspec list

echo.
set /P ENV_NAME="Enter the env/kernel name to DELETE (must match kernel name): "

REM --- Prevent deleting base ---
if /I "%ENV_NAME%"=="base" (
    echo.
    echo ERROR: Deleting the base environment is not allowed.
    pause
    goto END
)

REM --- Check env exists (path-based, Windows-safe) ---
conda info --envs | findstr /I "%USERPROFILE%\anaconda3\envs\%ENV_NAME%" >nul
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ERROR: Conda environment "%ENV_NAME%" was not found.
    echo Expected at: %USERPROFILE%\anaconda3\envs\%ENV_NAME%
    pause
    goto END
)

echo.
echo You are about to PERMANENTLY delete:
echo   - Conda environment: %ENV_NAME%
echo   - Jupyter kernel:    %ENV_NAME%
echo.
set /P CONFIRM="Are you sure? (y/n): "

if /I NOT "%CONFIRM%"=="y" (
    echo.
    echo Operation cancelled.
    goto END
)

echo.
echo === Removing Jupyter kernel (if it exists) ===
jupyter kernelspec remove "%ENV_NAME%" -f >nul 2>&1

echo.
echo === Removing conda environment ===
call conda remove -y -n %ENV_NAME% --all

echo.
echo Environment and kernel successfully removed.
pause
goto END

:END
echo.
echo Done.
