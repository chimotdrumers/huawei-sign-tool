title firmware generated
@echo off
@echo off          
@echo ##########################################################################
@echo                       successfull generating firmware find list below 
@echo ##########################################################################

@echo off
cd bin
tree /f >firmwaregenerated.txt
tree /f
timeout 7
start .

exit