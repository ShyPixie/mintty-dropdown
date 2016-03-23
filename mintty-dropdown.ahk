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

shell = /bin/tmux -2 new-session -A -s mintty-dropdown -t principal
mintty = %binDir%\mintty.exe
console = %mintty% --class mintty-dropdown %shell%

height = 400

setGeometry() {
    global

    WinSet, AlwaysOnTop, On, %window%
    WinSet,   Style, -0x00C00000, %window% ; WS_CAPTION
    WinSet,   Style, -0x00040000, %window% ; WS_THICKFRAME
    WinSet,   Style, -0x00200000, %window% ; WS_VSCROLL
    WinSet, ExStyle,  0x00000080, %window% ; WS_EX_TOOLWINDOW

    WinMove, %window%,, 0, 0, A_ScreenWidth, %height%
}

start() {
    global

    Run %console%, %binDir%, Hide
    WinWait %window%
}

checkWinStatus() {
    global

    ifWinActive %window%
    {
        DetectHiddenWindows off
        WinGet, temp_window,, %window%
        if %temp_window%
        {
            return "hide"
        }
        DetectHiddenWindows on
        return "show"
    }
    else
    {
        DetectHiddenWindows off
        WinGet, temp_window,, %window%
        if %temp_window%
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
        WinHide %window%
    }
    else
    {
        WinShow %window%
        WinActivate %window%
    }
}

Launch_App2::
    window = ahk_class mintty-dropdown

    IfWinNotExist %window%
    {
        start()
    }

    setGeometry()
    toggle()

    return

BtnExit:
    window = ahk_class mintty-dropdown

    IfWinExist %window%
    {
        WinClose
    }

    ExitApp
