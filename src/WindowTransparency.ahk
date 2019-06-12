; Win + T + Mouse wheel = Adjust transparency of window under cursor
; Win + TT = Remove transparency on active window
#InstallKeybdHook
#MaxHotkeysPerInterval 100
#HotkeyInterval 1000

global transparencyTarget := "A" ; The window that we'd like to change the transparency of.

#$T:: ; Win + T
	; Lock in which window we affect in case the cursor drifts or the target window becomes fully transparent.
	MouseGetPos(, , mouseWindow)
	transparencyTarget := "ahk_id " . mouseWindow

	; Hold Win and Double tap T to remove current window's transparency (since we can't mouse-over a completely invisible window)
	if ((A_PriorHotkey == A_ThisHotkey) and (A_TimeSincePriorHotkey > 0) and (A_TimeSincePriorHotkey < 250))
		WinSetTransparent("OFF", "A")
	KeyWait("T") ; Wait for T key to be released so that Windows' built-in key repeat feature doesn't trigger a double-tap automatically.
return

#WheelDown:: ; Win + Mousewheel down
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

#WheelUp:: ; Win + Mousewheel up
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
