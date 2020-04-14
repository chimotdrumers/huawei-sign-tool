@REM Set the packaged upgrade bin file storage path
set FILE_PATH=bin
set FILE_ISO_PATH=%FILE_PATH%\ISO
del /q /f %FILE_ISO_PATH%\*.*

@REM Upgrade bin file storage path if it does not exist, create
@if not exist %FILE_PATH% mkdir %FILE_PATH%
@if not exist %FILE_ISO_PATH% mkdir %FILE_ISO_PATH% 

@REM delete all bin files in the current directory
@if exist *.bin del /f /a *.bin

call VersionDefine.bat
call .\bat\MakeUpdate_ISO.bat %DASHBOARD_VER% 