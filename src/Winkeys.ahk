#Warn  ; Enable warnings to assist with detecting common errors.
SendMode "Input"

; Win + T + Mouse wheel = Adjust transparency of window under cursor
; Win + TT = Remove transparency on active window
#include WindowTransparency.ahk

; Win + F4 = Force kill active window's process (like using 'end task' in task manager)
#include KillTask.ahk

; Win + Alt + Enter = Toggle current window between borderless fullscreen and windowed
#include BorderlessWindow.ahk

; Win + A = Toggles whether the current window will always display on top of other windows or not
#include AlwaysOnTop.ahk
