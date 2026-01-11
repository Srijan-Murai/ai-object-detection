@echo off
set /P ENV_NAME="conda env name to use (e.g. base): "

echo.
echo === Activating conda environment: %ENV_NAME% ===
call conda activate %ENV_NAME%

echo.
echo === Installed Jupyter Kernels ===
echo.
jupyter kernelspec list

echo.
set /P KERNEL_NAME="Enter the EXACT kernel name to delete (or press Enter to cancel): "

if "%KERNEL_NAME%"=="" (
    echo.
    echo No kernel selected. Exiting.
    goto :EOF
)

echo.
echo You are about to delete the kernel: %KERNEL_NAME%
set /P CONFIRM="Are you sure? (y/n): "

if /I NOT "%CONFIRM%"=="y" (
    echo.
    echo Operation cancelled.
    goto :EOF
)

echo.
echo === Deleting kernel: %KERNEL_NAME% ===
jupyter kernelspec uninstall "%KERNEL_NAME%"

echo.
echo Done.
pause
