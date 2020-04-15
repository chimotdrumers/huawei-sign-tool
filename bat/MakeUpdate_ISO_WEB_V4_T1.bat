@if "%1" =="" goto usage1
@if "%2" =="" goto usage2

del /f /q *.bin
cd ./Images

@REM determines if the number of images is complete
@echo off
set FILE_NAME=00-000a0000-Oeminfo.bin
@if not exist %FILE_NAME% goto usage4
set FILE_NAME=01-000b0000-CDROMISO.bin
@if not exist %FILE_NAME% goto usage4
set FILE_NAME=02-005b0000-WEBUI.bin
@if not exist %FILE_NAME% goto usage4

:usage4
@echo off
@ren *Oeminfo*.bin 00-000a0000-Oeminfo.bin
@ren *CDROMISO*.bin 01-000b0000-CDROMISO.bin
@ren *WEBUI*.bin 02-005b0000-WEBUI.bin

@REM determines if the number of images is complete
@echo on
set FILE_NAME=00-000a0000-Oeminfo.bin
@if not exist %FILE_NAME% goto usage3
set FILE_NAME=01-000b0000-CDROMISO.bin
@if not exist %FILE_NAME% goto usage3
set FILE_NAME=02-005b0000-WEBUI.bin
@if not exist %FILE_NAME% goto usage3

@REM Back to previous directory
cd ../

@REM packages a one-click upgrade image into zlib compression format and deletes all zlib files in the zlib_temp directory.
set ZLIB_FILE_TEMP=zlib_temp
@if not exist %ZLIB_FILE_TEMP% mkdir %ZLIB_FILE_TEMP%
@if exist %ZLIB_FILE_TEMP% del /q /f %ZLIB_FILE_TEMP%\*.*

IsohdGen.exe -v%1 -t./Images/00-000a0000-Oeminfo.bin

sign.exe ./xml/packet_iso_webui_V4_T1.xml -p %1 %2

@REM starts compressing
C:\Python25\python compress.py c ./Images/00-000a0000-Oeminfo.bin ./%ZLIB_FILE_TEMP%/00-000a0000-Oeminfo.zlib 9
C:\Python25\python compress.py c ./Images/01-000b0000-CDROMISO.bin ./%ZLIB_FILE_TEMP%/01-000b0000-CDROMISO.zlib 9
C:\Python25\python compress.py c ./Images/02-005b0000-WEBUI.bin ./%ZLIB_FILE_TEMP%/02-005b0000-WEBUI.zlib 9

@REM delete all mbn, bin files in the current directory
@if exist *.mbn del /f /a *.mbn
@if exist *.bin del /f /a *.bin

merge.exe ./xml/packet_iso_webui_V4_T1.xml -p UPDATE_%1.BIN
merge.exe ./xml/packet_iso_webui_V4_zip_t1.xml -p UPDATE_%1.ZIP

@REM delete the mbn file of the current directory
@if exist *.mbn   del /f /a *.mbn  
@if exist MOBILE_CONNECT_HD.bin del /f /a MOBILE_CONNECT_HD.bin

WizGen.exe "%1"  
@move update_%1.bin %FILE_FIRMWARE_PATH%
@move update_%1.zip %FILE_FIRMWARE_PATH%
@move update_*.exe %FILE_FIRMWARE_PATH%
@echo ##########################################################
@echo ####  Congratulations, the package is successful.
@echo ####  please check %FILE_FIRMWARE_PATH% Get the upgrade package  
@echo ##########################################################
@echo ####  Upgrade package version number 		 %SOFTWARE_VER%
@echo ####  WEBUI version number         		 %WEBUI_VER%
@echo ####  Background version number 		 %DASHBOARD_VER%
@echo ####  Upgrade package ID 			 %FILE_DLOAD_ID%
@echo ####  Productroduct name 			 %FILE_PRODUCT_NAME%
@echo ##########################################################

timeout 5
exit
 
:usage1
@echo off
echo Error: Please input the dashboard type

:usage2
@echo off
echo Error: Please input the webui version

:usage3
@echo off
echo Error: Please provide the %FILE_NAME% image,thanks!
timeout 5
exit
