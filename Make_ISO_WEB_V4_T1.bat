@REM Set the packaged upgrade bin file storage path
set FILE_PATH=bin
set FILE_FIRMWARE_PATH=bin\ISO_WEB_V4_T1
del /q /f %FILE_FIRMWARE_PATH%\*.*

@REM The upgrade bin file storage path is created if it does not exist.
@if not exist %FILE_PATH% mkdir %FILE_PATH%
@if not exist %FILE_FIRMWARE_PATH% mkdir %FILE_FIRMWARE_PATH%

@REM delete all bin files in the current directory
@if exist *.bin del /f /a *.bin

echo off

call VersionDefine.bat
call .\bat\MakeUpdate_ISO_WEB_V4_T1.bat %DASHBOARD_VER% %WEBUI_VER%
timeout 5
exit