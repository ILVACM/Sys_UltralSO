@ECHO OFF&(PUSHD "%~DP0")&(REG QUERY "HKU\S-1-5-19">NUL 2>&1)||(
powershell -Command "Start-Process '%~sdpnx0' -Verb RunAs"&&EXIT)

::���ñ�Яģʽ�����ļ�(��Ϊ��Яģʽ��֧��ISO�����������),������������ע����ֵ
if exist ultraiso.ini ren ultraiso.ini ultraiso.ini.bak
::Ԥ�����·��, �رս�����Ч/����Ĭ��Ƥ��/Ӳ��д�뷽ʽ����Ĭ��USB-HDD+ v2+�߶�����
reg add "HKLM\Software\EasyBoot Systems\UltraISO\5.0" /f /ve /d "%~dp0\" >NUL 2>NUL
reg add "HKLM\Software\EasyBoot Systems\UltraISO\5.0" /f /v "Install" /d "1" >NUL 2>NUL
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /f /ve /d "%~dp0\" >NUL 2>NUL
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /f /v "USBMode" /d "4" >NUL 2>NUL
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /f /v "USBBootPart" /d "2" >NUL 2>NUL
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /f /v "UPlusV2Level" /d "3" >NUL 2>NUL
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /f /v "ISOFolder" /d "%userprofile%\Desktop\" >NUL 2>NUL
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /f /v "UseSkins" /d "1" >NUL 2>NUL
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /f /v "SoundEffect" /d "0" >NUL 2>NUL
reg add "HKCU\Software\EasyBoot Systems\UltraISO\5.0" /f /v "XPBurn" /d "0" >NUL 2>NUL
::��װ�����������ISO������֧��
PUSHD drivers & IsoCmd.exe -i >NUL 2>NUL & PUSHD ..
reg add "HKLM\SYSTEM\CurrentControlSet\Services\ISODrive\Parameters" /f /v "AutoMount" /t REG_DWORD /d "1" >NUL 2>NUL
::����ISO�ļ������Ҽ�UltraISO��
reg add "HKCR\.bin" /f /ve /d "binimage" >NUL 2>NUL
reg add "HKCR\.iso" /f /ve /d "UltraISO" >NUL 2>NUL
reg add "HKCR\.isz" /f /ve /d "UltraISO" >NUL 2>NUL
reg add "HKCR\.ui" /f /ve /d "UltraISO" >NUL 2>NUL
reg add "HKCR\binimage" /f /ve /d "BIN �ļ�" >NUL 2>NUL
reg add "HKCR\binimage\DefaultIcon" /f /ve /d "\"%~dp0UltraISO.exe\",0" >NUL 2>NUL
reg add "HKCR\binimage\shell\Convert to ISO\command" /f /ve /d "\"%~dp0UltraISO.exe\" -bin2iso \"%%1\"" >NUL 2>NUL
reg add "HKCR\binimage\shell\open\command" /f /ve /d "\"%~dp0UltraISO.exe\" \"%%1\"" >NUL 2>NUL
reg add "HKCR\UltraISO" /f /ve /d "UltraISO �ļ�" >NUL 2>NUL
reg add "HKCR\UltraISO\DefaultIcon" /f /ve /d "\"%~dp0UltraISO.exe\",0" >NUL 2>NUL
reg add "HKCR\UltraISO\shell\open" /f /ve /d "�� &UltraISO ��" >NUL 2>NUL
reg add "HKCR\UltraISO\shell\open\command" /f /ve /d "\"%~dp0UltraISO.exe\" \"%%1\"" >NUL 2>NUL
IF NOT EXIST "%ProgramW6432%" (
regsvr32 /s isoshell.dll
) else (
regsvr32 /s isoshl64.dll
)
assoc .=. >NUL 2>NUL
IF EXIST "%WinDir%\System32\CHOICE.exe" ECHO.&ECHO ��� &TIMEOUT /t 2 >NUL&EXIT
IF NOT EXIST "%WinDir%\System32\CHOICE.exe" ECHO.&ECHO ��ɣ����������! &PAUSE>NUL