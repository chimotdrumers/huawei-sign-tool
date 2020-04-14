@if "%1" =="" goto usage1

del /f /q *.bin
cd ./Images

@REM 判断镜像数目是否完整
set FILE_NAME=MOBILE_CONNECT.ISO
@if not exist %FILE_NAME% goto usage2

@REM 回到上一目录
cd ../

@REM 将一键升级镜像打包成zlib压缩格式,并删除zlib_temp目录下的所有zlib文件
set ZLIB_FILE_TEMP=zlib_temp
@if not exist %ZLIB_FILE_TEMP% mkdir %ZLIB_FILE_TEMP%
@if exist %ZLIB_FILE_TEMP% del /q /f %ZLIB_FILE_TEMP%\*.*

@REM 删除当前目录下的所有mbn,bin文件
@if exist *.mbn del /f /a *.mbn
@if exist *.bin del /f /a *.bin

IsohdGen.exe -v%1 -t./Images/ISOhd.iso

sign.exe ./xml/packet_iso.xml %1

@REM 开始压缩
C:\Python25\python compress.py c ./Images/ISOhd.iso ./%ZLIB_FILE_TEMP%/ISOhd.zlib 9
C:\Python25\python compress.py c ./Images/MOBILE_CONNECT_s.ISO ./%ZLIB_FILE_TEMP%/MOBILE_CONNECT_s.zlib 9

merge.exe ./xml/packet_iso.xml -p UPDATE_%1.BIN
merge.exe ./xml/packet_iso_zip.xml -p UPDATE_%1.ZIP

@REM 删除当前目录的mbn文件
@if exist *.mbn   del /f /a *.mbn  
@if exist MOBILE_CONNECT_HD.bin del /f /a MOBILE_CONNECT_HD.bin

WizGen.exe "%1"  
@move update_%1.bin %FILE_ISO_PATH%
@move update_%1.zip %FILE_ISO_PATH%
@move update_*.exe %FILE_ISO_PATH%
@echo ##########################################################
@echo ######  恭喜你，打包成功了，请到%FILE_ISO_PATH%下获取升级包   
@echo ##########################################################
@echo ######  后台版本号	%DASHBOARD_VER%
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