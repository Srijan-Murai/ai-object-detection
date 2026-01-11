:: albumentations labelme matplotlib opencv-python tensorflow 2.10.1 (GPU-safe)

@echo off
set /P ENV_NAME="conda env name: "

REM === 1. Initialize Conda for this shell ===
call "%USERPROFILE%\anaconda3\Scripts\activate.bat"

echo.
echo === 2. Creating conda environment: %ENV_NAME% ===
call conda create -y -n %ENV_NAME% python=3.10.19

echo.
echo === 3. Activating conda environment ===
call conda activate %ENV_NAME%

echo.
echo === 4. Upgrading pip ===
python -m pip install --upgrade pip

echo.
echo === 5. Installing packages ===
pip install tensorflow==2.10.1 albumentations labelme matplotlib opencv-python ipykernel jupyterlab

echo.
echo === 6. Registering Jupyter kernel ===
python -m ipykernel install --user --name=%ENV_NAME% --display-name=%ENV_NAME%

echo.
echo === 7. Setup Complete. Launching JupyterLab... ===
jupyter lab
