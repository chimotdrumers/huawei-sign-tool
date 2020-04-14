@if "%1" =="" goto usage1
@if "%2" =="" goto usage2
@if "%3" =="" goto usage3

del /f /q *.bin
cd ./Images

@echo off
@ren *Fastboot*.bin 00-00110000-Fastboot.bin
@ren *M3Boot_R11*.bin 01-00200000-M3Boot_R11.bin
@ren *M3Boot-ptable*.bin 02-00010000-M3Boot-ptable.bin
@ren *M3Image_R11*.bin 03-00230000-M3Image_R11.bin
@ren *DTS_R11*.bin 04-00270000-DTS_R11.bin
@ren *Kernel_R11*.bin 05-00090000-Kernel_R11.bin
@ren *Modem_fw*.bin 06-001e0000-Modem_fw.bin
@ren *HIFI_R11*.bin 07-00280000-HIFI_R11.bin
@ren *Nvdload_R11*.bin 08-00250000-Nvdload_R11.bin
@ren *System*.bin 09-00590000-System.bin
@ren *APP*.bin 10-005a0000-APP.bin

@REM determines if the number of images is complete
@echo on
set FILE_NAME=00-00110000-Fastboot.bin
@if not exist %FILE_NAME% goto usage4
set FILE_NAME=01-00200000-M3Boot_R11.bin
@if not exist %FILE_NAME% goto usage4 
set FILE_NAME=02-00010000-M3Boot-ptable.bin
@if not exist %FILE_NAME% goto usage4
set FILE_NAME=03-00230000-M3Image_R11.bin
@if not exist %FILE_NAME% goto usage4
set FILE_NAME=04-00270000-DTS_R11.bin
@if not exist %FILE_NAME% goto usage4
set FILE_NAME=05-00090000-Kernel_R11.bin
@if not exist %FILE_NAME% goto usage4
set FILE_NAME=06-001e0000-Modem_fw.bin
@if not exist %FILE_NAME% goto usage4
set FILE_NAME=07-00280000-HIFI_R11.bin
@if not exist %FILE_NAME% goto usage4
set FILE_NAME=08-00250000-Nvdload_R11.bin
@if not exist %FILE_NAME% goto usage4
set FILE_NAME=09-00590000-System.bin
@if not exist %FILE_NAME% goto usage4
set FILE_NAME=10-005a0000-APP.bin
@if not exist %FILE_NAME% goto usage4


@REM Back to previous directory
@echo off
cd ../

@REM component signature first
sign.exe ./xml/packet_fw_V5_T1.xml -p %1 %2

@REM packages a one-click upgrade image into zlib compression format and deletes all zlib files in the zlib_temp directory.
set ZLIB_FILE_TEMP=zlib_temp
@if not exist %ZLIB_FILE_TEMP% mkdir %ZLIB_FILE_TEMP%
@if exist %ZLIB_FILE_TEMP% del /q /f %ZLIB_FILE_TEMP%\*.*

C:\Python25\python compress.py c ./Images/00-00110000-Fastboot-s.bin ./%ZLIB_FILE_TEMP%/00-00110000-Fastboot-s.zlib 9
C:\Python25\python compress.py c ./Images/01-00200000-M3Boot_R11.bin ./%ZLIB_FILE_TEMP%/01-00200000-M3Boot_R11.zlib 9
C:\Python25\python compress.py c ./Images/02-00010000-M3Boot-ptable.bin ./%ZLIB_FILE_TEMP%/02-00010000-M3Boot-ptable.zlib 9
C:\Python25\python compress.py c ./Images/03-00230000-M3Image_R11.bin ./%ZLIB_FILE_TEMP%/03-00230000-M3Image_R11.zlib 9
C:\Python25\python compress.py c ./Images/04-00270000-DTS_R11.bin ./%ZLIB_FILE_TEMP%/04-00270000-DTS_R11.zlib 9
C:\Python25\python compress.py c ./Images/05-00090000-Kernel_R11.bin ./%ZLIB_FILE_TEMP%/05-00090000-Kernel_R11.zlib 9
C:\Python25\python compress.py c ./Images/06-001e0000-Modem_fw.bin ./%ZLIB_FILE_TEMP%/06-001e0000-Modem_fw.zlib 9
C:\Python25\python compress.py c ./Images/07-00280000-HIFI_R11.bin ./%ZLIB_FILE_TEMP%/07-00280000-HIFI_R11.zlib 9
C:\Python25\python compress.py c ./Images/08-00250000-Nvdload_R11.bin ./%ZLIB_FILE_TEMP%/08-00250000-Nvdload_R11.zlib 9
C:\Python25\python compress.py c ./Images/09-00590000-System.bin ./%ZLIB_FILE_TEMP%/09-00590000-System.zlib 9
C:\Python25\python compress.py c ./Images/10-005a0000-APP.bin ./%ZLIB_FILE_TEMP%/10-005a0000-APP.zlib 9

@REM delete all mbn, bin files in the current directory
@if exist *.mbn del /f /a *.mbn
@if exist *.bin del /f /a *.bin

merge.exe ./xml/packet_fw_V5_T1.xml -p :%1:%2 %3_UPDATE_%2.BIN
merge.exe ./xml/packet_fw_V5_zip_T1.xml -p :%1:%2 %3_UPDATE_%2.ZIP

@REM delete the mbn file of the current directory
@if exist *.mbn   del /f /a *.mbn  
@if exist MOBILE_CONNECT_HD.bin del /f /a MOBILE_CONNECT_HD.bin

@echo on

WizGen.exe "%3" 
@move %3_update_%2.bin %FILE_FIRMWARE_PATH%
@move %3_update_%2.zip %FILE_FIRMWARE_PATH%
@move %3_update_*.exe %FILE_FIRMWARE_PATH%
@echo off
@echo ##########################################################
@echo ####  Congratulations, the package is successful.
@echo ####  please check  %FILE_FIRMWARE_PATH%  Get the upgrade package  
@echo ##########################################################
@echo ####  Upgrade package version number 		 %SOFTWARE_VER%
@echo ####  Background version number 		 %DASHBOARD_VER%
@echo ####  Upgrade package ID 			 %FILE_DLOAD_ID%
@echo ####  Productroduct name 			 %FILE_PRODUCT_NAME%
@echo ##########################################################
@pause
exit
exit
:usage1
@echo off
echo Error: Please provide the dload_id

:usage2
@echo off
echo Error: Please provide the firmware version

:usage3
@echo off
echo Error: Please provide the product name

:usage4
@echo off
echo Error: Please provide the %FILE_NAME% image,thanks!
pause
