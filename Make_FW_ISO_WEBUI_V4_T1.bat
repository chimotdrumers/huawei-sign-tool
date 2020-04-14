@REM Set up the packaged upgrade bin File storage path
set FILE_PATH=bin
set FILE_FIRMWARE_PATH=%FILE_PATH%\FW_ISO_WEBUI_V4_T1

@REM The upgrade bin file storage path is created if it does not exist.
@if not exist %FILE_PATH% mkdir %FILE_PATH%
@if not exist %FILE_FIRMWARE_PATH% mkdir %FILE_FIRMWARE_PATH%

@REM Delete all bin files in the current directory
@if exist *.bin del /f /a *.bin
call VersionDefine.bat
call .\bat\MakeUpdate_FW_ISO_WEBUI_V4_T1.bat %FILE_DLOAD_ID% %SOFTWARE_VER% %DASHBOARD_VER% %FILE_PRODUCT_NAME% %WEBUI_VER%