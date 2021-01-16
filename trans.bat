start /wait cmd /k call Make_FW_ISO_WEBUI_V4_T1.bat 1
start /wait cmd /k call Make_FW_V4_T1.bat 2
start /wait cmd /k call Make_FW_V4_T2.bat 3
start /wait cmd /k call Make_FW_WEBUI_V4.bat 4
start /wait cmd /k call Make_ISO_WEB_V4_T1.bat 5
start /wait cmd /k call Make_FW_ISO_WEBUI_LOGO_V4_T1.bat 6
start /wait cmd /k call Make_FW_ISO_WEBUI_LOGO_V4_T2.bat 7
start /wait cmd /k call Make_FW_LOGO_WEBUI_V4_T1.bat 8
start /wait cmd /k call Make_FW_LOGO_V4_T1.bat 9
start /wait cmd /k call Make_FW_LOGO_V4_T2.bat 10
start /wait cmd /k call message.bat 11
timeout 3
exit