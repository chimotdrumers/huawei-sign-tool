@REM sets the packaged upgrade bin file storage path
set FILE_PATH=bin
set FILE_FIRMWARE_PATH=%FILE_PATH%\FW_LOGO
set SIGN_PATH=%FILE_PATH%\FW_LOGO\signtool
del /q /f %FILE_FIRMWARE_PATH%\*.*

@The REM upgrade bin file storage path is created if it does not exist.
@if not exist %FILE_PATH% mkdir %FILE_PATH%
@if not exist %FILE_FIRMWARE_PATH% mkdir %FILE_FIRMWARE_PATH%

@REM delete all bin files in the current directory
@if exist *.bin del /f /a *.bin

call VersionDefine.bat
call .\bat\MakeUpdate_FW_LOGO.bat %FILE_DLOAD_ID% %SOFTWARE_VER% %FILE_PRODUCT_NAME%