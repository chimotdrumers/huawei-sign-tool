@if "%1" =="" goto usage1
@if "%2" =="" goto usage2
@if "%3" =="" goto usage3
@if "%4" =="" goto usage4

del /f /q *.bin
cd ./Images

@REM �жϾ�����Ŀ�Ƿ�����
set FILE_NAME=m3boot.bin
@if not exist %FILE_NAME% goto usage5
set FILE_NAME=ptable.bin
@if not exist %FILE_NAME% goto usage5 
set FILE_NAME=fastboot.img
@if not exist %FILE_NAME% goto usage5
set FILE_NAME=boot.img
@if not exist %FILE_NAME% goto usage5
set FILE_NAME=bsp_mcore.bin
@if not exist %FILE_NAME% goto usage5
set FILE_NAME=lphy.bin
@if not exist %FILE_NAME% goto usage5 
set FILE_NAME=balongv7r2_mcore.bin
@if not exist %FILE_NAME% goto usage5
set FILE_NAME=nv.bin
@if not exist %FILE_NAME% goto usage5
set FILE_NAME=update.zip
@if not exist %FILE_NAME% goto usage5

@REM �ص���һĿ¼
cd ../

@REM �����ǩ��
sign.exe ./xml/packet_hota.xml -p %1 %2 %4

@REM ��һ��������������zlibѹ����ʽ,��ɾ��zlib_tempĿ¼�µ�����zlib�ļ�
set ZLIB_FILE_TEMP=zlib_temp
@if not exist %ZLIB_FILE_TEMP% mkdir %ZLIB_FILE_TEMP%
@if exist %ZLIB_FILE_TEMP% del /q /f %ZLIB_FILE_TEMP%\*.*

C:\Python27\python compress.py c ./Images/m3boot.bin ./%ZLIB_FILE_TEMP%/m3boot.zlib 9
C:\Python27\python compress.py c ./Images/ptable.bin ./%ZLIB_FILE_TEMP%/ptable.zlib 9
C:\Python27\python compress.py c ./Images/fastboot_s.img ./%ZLIB_FILE_TEMP%/fastboot_s.zlib 9
C:\Python27\python compress.py c ./Images/bsp_mcore.bin ./%ZLIB_FILE_TEMP%/bsp_mcore.zlib 9
C:\Python27\python compress.py c ./Images/lphy.bin ./%ZLIB_FILE_TEMP%/lphy.zlib 9
C:\Python27\python compress.py c ./Images/balongv7r2_mcore.bin ./%ZLIB_FILE_TEMP%/balongv7r2_mcore.zlib 9
C:\Python27\python compress.py c ./Images/nv.bin ./%ZLIB_FILE_TEMP%/nv.zlib 9
C:\Python27\python compress.py c ./Images/boot.img ./%ZLIB_FILE_TEMP%/boot.zlib 9
C:\Python27\python compress.py c ./Images/update.zip ./%ZLIB_FILE_TEMP%/update.zlib 9

@REM ɾ����ǰĿ¼�µ�����mbn,bin�ļ�
@if exist *.mbn del /f /a *.mbn
@if exist *.bin del /f /a *.bin

merge.exe ./xml/packet_hota.xml -p :%1:%2 %3_UPDATE_%2.BIN
merge.exe ./xml/packet_hota_zip.xml -p :%1:%2 %3_UPDATE_%2.ZIP

@REM ɾ����ǰĿ¼��mbn�ļ�
@if exist *.mbn   del /f /a *.mbn  
@if exist MOBILE_CONNECT_HD.bin del /f /a MOBILE_CONNECT_HD.bin

WizGen.exe "%3" 
@move %3_update_%2.bin %FILE_FIRMWARE_PATH%
@move %3_update_%2.zip %FILE_FIRMWARE_PATH%
@move %3_update_*.exe %FILE_FIRMWARE_PATH%
@echo ##########################################################
@echo ######  ��ϲ�㣬����ɹ��ˣ��뵽%FILE_FIRMWARE_PATH%�»�ȡ������   
@echo ##########################################################
@echo ######  �������汾��			%SOFTWARE_VER%
@echo ######  ������ID			%FILE_DLOAD_ID%
@echo ######  ��Ʒ����			%FILE_PRODUCT_NAME%
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
echo Error: Please input the webui version

:usage5
@echo off
echo Error: Please provide the %FILE_NAME% image,thanks!
pause
