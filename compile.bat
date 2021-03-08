taskkill /im Winkies.exe
setlocal cd=%CD%
START /d "C:\Users\blacr\Dropbox\Scripts\AutoHotkey_2.0-a104-3e7a969d\Compiler\" /wait Ahk2exe.exe /in %cd%/src/Winkies.ahk /out %cd%/bin/Winkies.exe /icon %cd%/Winkies.ico
START "" "bin/Winkies.exe"