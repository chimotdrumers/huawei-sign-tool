@if "%1" =="" goto usage1

del /f /q *.bin
cd ./Images

@REM �жϾ�����Ŀ�Ƿ�����
set FILE_NAME=02-005b0000-WEBUI.bin
@if not exist %FILE_NAME% goto usage3

@REM �ص���һĿ¼
cd ../

@REM ��һ��������������zlibѹ����ʽ,��ɾ��zlib_tempĿ¼�µ�����zlib�ļ�
set ZLIB_FILE_TEMP=zlib_temp
@if not exist %ZLIB_FILE_TEMP% mkdir %ZLIB_FILE_TEMP%
@if exist %ZLIB_FILE_TEMP% del /q /f %ZLIB_FILE_TEMP%\*.*

IsohdGen.exe -v%1 -t./Images/webuihd.img

sign.exe ./xml/packet_webui.xml -p %1


@REM ɾ����ǰĿ¼�µ�����mbn,bin�ļ�
@if exist *.mbn del /f /a *.mbn
@if exist *.bin del /f /a *.bin

merge.exe ./xml/packet_webui.xml -p UPDATE_%1.BIN

@REM ɾ����ǰĿ¼��mbn�ļ�
@if exist *.mbn   del /f /a *.mbn  
@if exist MOBILE_CONNECT_HD.bin del /f /a MOBILE_CONNECT_HD.bin

WizGen.exe "%1"  
@move update_%1.bin %FILE_WEB_PATH%
@move update_%1.zip %FILE_WEB_PATH%
@move update_*.exe %FILE_WEB_PATH%
@echo ##########################################################
@echo ######  ��ϲ�㣬����ɹ��ˣ��뵽%FILE_WEB_PATH%�»�ȡ������   
@echo ##########################################################
@echo ######  WEBUI�汾��	%WEBUI_VER%
@echo ##########################################################

exit /B
exit /B

exit /B
:usage1
@echo off
echo Error: Please input the dashboard type

:usage2
@echo off
echo Error: Please input the webui version

:usage3
@echo off
echo Error: Please provide the %FILE_NAME% image,thanks!
