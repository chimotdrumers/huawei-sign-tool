@echo off
echo on
cd ..
del *.bin
cd balong

@ren *1*.Bin f.bin
@ren *2*.Bin f.bin
@ren *3*.Bin f.bin
@ren *4*.Bin f.bin
@ren *5*.Bin f.bin
@ren *6*.Bin f.bin
@ren *7*.Bin f.bin
@ren *8*.Bin f.bin
@ren *9*.Bin f.bin
@ren *0*.Bin f.bin
@ren *1*.zip f.bin
@ren *2*.zip f.bin
@ren *3*.zip f.bin
@ren *4*.zip f.bin
@ren *5*.zip f.bin
@ren *6*.zip f.bin
@ren *7*.zip f.bin
@ren *8*.zip f.bin
@ren *9*.zip f.bin
@ren *0*.zip f.bin
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
call b.exe -fe f.bin
@move *0*.bin ..
cd ..
start .
@timeout /t 10 /nobreak

cd ..


call trans.bat
exit
