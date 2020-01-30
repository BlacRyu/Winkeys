; Win + T + Mouse wheel = Adjust transparency of window under cursor
; Win + TT = Remove transparency on active window
; Win + T + C = Toggle click-through
#InstallKeybdHook
#MaxHotkeysPerInterval 100
#HotkeyInterval 1000

global transparencyTarget := "A" ; The window that we'd like to change the transparency of.

#$T:: ; Win + T, (Win + TT)
	; Lock in which window we affect in case the cursor drifts or the target window becomes fully transparent.
	MouseGetPos(, , mouseWindow)
	transparencyTarget := "ahk_id " . mouseWindow

	; Hold Win and Double tap T to remove current window's transparency (since we can't mouse-over a completely invisible window)
	if ((A_PriorHotkey == A_ThisHotkey) and (A_TimeSincePriorHotkey > 0) and (A_TimeSincePriorHotkey < 250))
	{
		WinSetExStyle("-0x20", transparencyTarget)	; disable click-through
		WinSetTransparent("OFF", "A") ; disable transparency
	}
	KeyWait("T") ; Wait for T key to be released so that Windows' built-in key repeat feature doesn't trigger a double-tap automatically.
return

#$C:: ; Win + C (+ T)
	if (GetKeyState("T", "P") == 1) ; Make sure T key is down as well
	{
		curStyle := WinGetExStyle("A")	; Get the style of the window
		if (curStyle != "")
		{
			if (curStyle & "+0x80000" and curStyle & "+0x20")		; if already click-through
				WinSetExStyle("-0x20", "A")	; disable click-through
			else
				WinSetExStyle("+0x80020", "A")		; enable click-through
		}
		Else
			SendInput "C"
	}
	else
		SendInput "C"
return

#WheelDown:: ; Win + Mousewheel down (+ T)
	if (GetKeyState("T", "P") == 1) ; Make sure T key is down as well
	{
		curTransparency := WinGetTransparent(transparencyTarget)
		if (curTransparency == "")
			curTransparency := 255
		newTransparency := Max(curTransparency - 15, 0)
		WinSetTransparent(newTransparency, transparencyTarget)
	}
	else
		SendInput "{WheelDown}"
return

#WheelUp:: ; Win + Mousewheel up (+ T)
	if (GetKeyState("T", "P") == 1) ; Make sure T key is down as well
	{
		curTransparency := WinGetTransparent(transparencyTarget)
		if (curTransparency != "") ; Do nothing if already opaque
		{
			newTransparency := curTransparency + 15
			if (newTransparency >= 255)
				WinSetTransparent("OFF", transparencyTarget) ; Disable transparency if fully opaque to improve performance
			Else
				WinSetTransparent(newTransparency, transparencyTarget)
		}
	}
	Else
		SendInput "{WheelUp}"
return
