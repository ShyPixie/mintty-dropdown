; This file is part of mintty-dropdown.
;
; Lara Maia <dev@lara.click> 2016
;
; mintty-dropdown is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.

; mintty-dropdown is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.

; You should have received a copy of the GNU General Public License
; along with mintty-dropdown.  If not, see <http://www.gnu.org/licenses/>.
;

#NoEnv
#SingleInstance ignore
SendMode Input
DetectHiddenWindows on

Menu, Tray, NoStandard
Menu, Tray, Add, Exit, BtnExit

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
    IfWinExist ahk_class mintty-dropdown
    {
        WinClose, ahk_class mintty-dropdown
    }

    ExitApp
