@REM Set the packaged upgrade bin file storage path
set FILE_PATH=bin
set FILE_FIRMWARE_PATH=%FILE_PATH%\FW
del /q /f %FILE_FIRMWARE_PATH%\*.*

@REM Upgrade bin file storage path if it does not exist, create
@if not exist %FILE_PATH% mkdir %FILE_PATH%
@if not exist %FILE_FIRMWARE_PATH% mkdir %FILE_FIRMWARE_PATH%

@REM delete all bin files in the current directory
@if exist *.bin del /f /a *.bin

call VersionDefine.bat
call .\bat\MakeUpdate_HOTA.bat %FILE_DLOAD_ID% %SOFTWARE_VER% %FILE_PRODUCT_NAME% %WEBUI_VER%