#NoEnv
#SingleInstance ignore
SendMode Input
DetectHiddenWindows on

;Menu, Tray, NoStandard
;Menu, Tray, Add, BtnExit

RegRead, cygwinDir, HKEY_LOCAL_MACHINE\SOFTWARE\Cygwin\setup, rootdir
binDir = %cygwinDir%\bin

shells = /usr/bin/fish
mintty = %binDir%\mintty.exe
console = %mintty% --class mintty-dropdown %shells%

height = 400

setGeometry() {
    global

    WinMove, ahk_class mintty-dropdown,, 0, 0, A_ScreenWidth, %height%
}

start() {
    global

    WinGet, previousWin, ID, A
    Run %console%, %binDir%, Hide
    WinWait ahk_class mintty-dropdown
    WinActivate ahk_id %previousWin%
}

checkWinStatus() {
    ifWinActive ahk_class mintty-dropdown
    {
        return "hide"
    }
    else
    {
        DetectHiddenWindows off
        WinGet, window,, ahk_class mintty-dropdown
        if %window%
        {
            return "hide"
        }
        DetectHiddenWindows On
        return "show"
    }
}

toggle() {
    global
    if InStr(checkWinStatus(), "hide")
    {
        WinHide ahk_class mintty-dropdown
        WinActivate ahk_id %previousWin%
    }
    else
    {
        WinGet, previousWin, ID, A
        WinShow ahk_class mintty-dropdown
        WinActivate ahk_class mintty-dropdown
    }
}

Launch_App2::
    IfWinNotExist ahk_class mintty-dropdown
    {
        start()
    }

    setGeometry()
    toggle()

    return

BtnExit:
    if ahk_class mintty-dropdown
    {
        WinClose, ahk_class mintty-dropdown
    }
    ExitApp
