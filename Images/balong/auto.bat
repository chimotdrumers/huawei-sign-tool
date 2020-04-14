@echo off
echo on
@ren **.bin f.bin
@ren **.zip f.bin
@ren *1*.exe f.bin
@ren *2*.exe f.bin
@ren *3*.exe f.bin
@ren *4*.exe f.bin
@ren *5*.exe f.bin
@ren *6*.exe f.bin
@ren *7*.exe f.bin
@ren *8*.exe f.bin
@ren *9*.exe f.bin
@ren *0*.exe f.bin
@ren **.zip f.bin
call balong_flash.exe -fe f.bin
@move *0*.bin ..
cd ..

cd ..

dir
call make_all.bat
pause
