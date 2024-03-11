@ECHO OFF&(PUSHD "%~DP0")&(REG QUERY "HKU\S-1-5-19">NUL 2>&1)||(
powershell -Command "Start-Process '%~sdpnx0' -Verb RunAs"&&EXIT)

::卸载虚拟光驱驱动
drivers\IsoCmd.exe -r >NUL 2>NUL
::清除ISO格式文件类型关联
IF NOT EXIST "%ProgramW6432%" (
regsvr32 /s /u isoshell.dll
) ELSE (
regsvr32 /s /u isoshl64.dll
)
::删除注册表残留键值(便携模式不依赖注册表)
reg delete "HKCR\.iso" /f >NUL 2>NUL
reg delete "HKCR\.isz" /f >NUL 2>NUL
reg delete "HKCR\.ui" /f >NUL 2>NUL
reg delete "HKCR\.bin" /f >NUL 2>NUL
reg delete "HKCR\binimage" /f >NUL 2>NUL
reg delete "HKCR\UltraISO" /f >NUL 2>NUL
reg delete "HKLM\Software\Classes\.iso" /f >NUL 2>NUL
reg delete "HKLM\Software\Classes\.isz" /f >NUL 2>NUL
reg delete "HKLM\Software\Classes\.img" /f >NUL 2>NUL
reg delete "HKLM\Software\Classes\.bin" /f >NUL 2>NUL
reg delete "HKLM\Software\Classes\.ui" /f >NUL 2>NUL
reg delete "HKLM\Software\Classes\UltraISO" /f >NUL 2>NUL
reg delete "HKCU\Software\EasyBoot Systems" /f >NUL 2>NUL
reg delete "HKLM\SOFTWARE\EasyBoot Systems" /f >NUL 2>NUL
reg delete "HKLM\SOFTWARE\WOW6432Node\EasyBoot Systems" /f >NUL 2>NUL
::启用便携模式配置文件
if exist ultraiso.ini.bak ren ultraiso.ini.bak ultraiso.ini
IF EXIST "%WinDir%\System32\CHOICE.exe" ECHO.&ECHO 完成 &TIMEOUT /t 2 >NUL&EXIT
IF NOT EXIST "%WinDir%\System32\CHOICE.exe" ECHO.&ECHO 完成，任意键返回! &PAUSE>NUL