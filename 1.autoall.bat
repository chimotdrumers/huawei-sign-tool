@echo off
cd images
@del /f /q *.bin
@if exist *.mbn del /f /a *.mbn
@if exist *.iso del /f /a *.iso
@if exist *.bin del /f /a *.bin
cd balong
start .

echo off          
start /wait cmd /k call view.bat
call auto.bat
timeout 3
exit
