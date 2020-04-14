@if "%1" =="" goto usage1

del /f /q *.bin
cd ./Images

@REM 判断镜像数目是否完整
set FILE_NAME=02-005b0000-WEBUI.bin
@if not exist %FILE_NAME% goto usage3

@REM 回到上一目录
cd ../

@REM 将一键升级镜像打包成zlib压缩格式,并删除zlib_temp目录下的所有zlib文件
set ZLIB_FILE_TEMP=zlib_temp
@if not exist %ZLIB_FILE_TEMP% mkdir %ZLIB_FILE_TEMP%
@if exist %ZLIB_FILE_TEMP% del /q /f %ZLIB_FILE_TEMP%\*.*

IsohdGen.exe -v%1 -t./Images/webuihd.img

sign.exe ./xml/packet_webui.xml -p %1


@REM 删除当前目录下的所有mbn,bin文件
@if exist *.mbn del /f /a *.mbn
@if exist *.bin del /f /a *.bin

merge.exe ./xml/packet_webui.xml -p UPDATE_%1.BIN

@REM 删除当前目录的mbn文件
@if exist *.mbn   del /f /a *.mbn  
@if exist MOBILE_CONNECT_HD.bin del /f /a MOBILE_CONNECT_HD.bin

WizGen.exe "%1"  
@move update_%1.bin %FILE_WEB_PATH%
@move update_%1.zip %FILE_WEB_PATH%
@move update_*.exe %FILE_WEB_PATH%
@echo ##########################################################
@echo ######  恭喜你，打包成功了，请到%FILE_WEB_PATH%下获取升级包   
@echo ##########################################################
@echo ######  WEBUI版本号	%WEBUI_VER%
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
