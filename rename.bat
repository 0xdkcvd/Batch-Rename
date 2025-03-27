@echo off
setlocal enabledelayedexpansion

:: Ask user for the folder path
set /p "folder=Enter the folder path: "

:: Check if the folder exists
if not exist "%folder%" (
    echo [ERROR] Folder not found! Please make sure the path is correct.
    pause
    exit
)

:: Ask user for the additional extension
:input_ext
set /p "ext=Enter the additional extension (without dot, e.g., txt, backup, log): "

:: Check if extension is empty
if "%ext%"=="" (
    echo [WARNING] Extension cannot be empty!
    goto input_ext
)

:: Show the extension that will be used
echo.
echo [INFO] The additional extension to be used: .%ext%
echo [INFO] Scanning files in folder "%folder%"...
echo.

:: Count the number of files found
set count=0
for /r "%folder%" %%f in (*) do set /a count+=1

:: If no files are found, stop the process
if %count%==0 (
    echo [WARNING] No files found in this folder.
    pause
    exit
)

:: Show the list of files before renaming
echo [INFO] Total files found: %count%
echo [INFO] The following files will be renamed:
for /r "%folder%" %%f in (*) do echo %%f
echo.

:: Ask for confirmation before renaming
set /p "confirm=Do you want to rename all these files with .%ext% extension? (y/n): "
if /i "%confirm%" neq "y" (
    echo [INFO] Process canceled by the user.
    pause
    exit
)

:: Process renaming files
echo.
echo [PROCESS] Renaming files...
for /r "%folder%" %%f in (*) do ren "%%f" "%%~nxf.%ext%"

:: Show success message
echo.
echo [SUCCESS] All files have been renamed with the additional .%ext% extension!
echo [INFO] Process completed.
pause
