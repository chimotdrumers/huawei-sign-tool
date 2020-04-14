@if "%1" =="" goto usage1

del /f /q *.bin
cd ./Images

@REM �жϾ�����Ŀ�Ƿ�����
set FILE_NAME=MOBILE_CONNECT.ISO
@if not exist %FILE_NAME% goto usage2

@REM �ص���һĿ¼
cd ../

@REM ��һ��������������zlibѹ����ʽ,��ɾ��zlib_tempĿ¼�µ�����zlib�ļ�
set ZLIB_FILE_TEMP=zlib_temp
@if not exist %ZLIB_FILE_TEMP% mkdir %ZLIB_FILE_TEMP%
@if exist %ZLIB_FILE_TEMP% del /q /f %ZLIB_FILE_TEMP%\*.*

@REM ɾ����ǰĿ¼�µ�����mbn,bin�ļ�
@if exist *.mbn del /f /a *.mbn
@if exist *.bin del /f /a *.bin

IsohdGen.exe -v%1 -t./Images/ISOhd.iso

sign.exe ./xml/packet_iso.xml %1

@REM ��ʼѹ��
C:\Python25\python compress.py c ./Images/ISOhd.iso ./%ZLIB_FILE_TEMP%/ISOhd.zlib 9
C:\Python25\python compress.py c ./Images/MOBILE_CONNECT_s.ISO ./%ZLIB_FILE_TEMP%/MOBILE_CONNECT_s.zlib 9

merge.exe ./xml/packet_iso.xml -p UPDATE_%1.BIN
merge.exe ./xml/packet_iso_zip.xml -p UPDATE_%1.ZIP

@REM ɾ����ǰĿ¼��mbn�ļ�
@if exist *.mbn   del /f /a *.mbn  
@if exist MOBILE_CONNECT_HD.bin del /f /a MOBILE_CONNECT_HD.bin

WizGen.exe "%1"  
@move update_%1.bin %FILE_ISO_PATH%
@move update_%1.zip %FILE_ISO_PATH%
@move update_*.exe %FILE_ISO_PATH%
@echo ##########################################################
@echo ######  ��ϲ�㣬����ɹ��ˣ��뵽%FILE_ISO_PATH%�»�ȡ������   
@echo ##########################################################
@echo ######  ��̨�汾��	%DASHBOARD_VER%
@echo ##########################################################
exit /B
exit /B


:usage1
@echo off
echo Error: Please input the dashboard version
exit /B

:usage2
@echo off
echo Error: Please provide the %FILE_NAME% image,thanks!
exit /B