# Mintty Drop-Down

A little [AutoHotkey](http://www.autohotkey.com/) script that adds
support for drop-down in the mintty.

## Dependencies
- [Cygwin (Click for information)](https://www.cygwin.com/)

## I need to build?
- If you have the [AutoHotkey](http://www.autohotkey.com/) installed so
you can just execute the mintty-dropdown.ahk, but if your don't have so
read "How To build" below.

## How to build?
1. Clone or download manually the git repository
2. Go to mintty-dropdown directory
3. Double click in the `Makefile.cmd` (or if you prefer you can use
    the `make` command through a cygwin terminal)
4. Finish. The binary is at mintty-dropdown.exe

## How to use?
1. Run mintty-dropdown
2. Press the Calculator key to toggle console

You can change the toggle key, default shell, terminal size, and other
options by editing the ahk script and building again.
