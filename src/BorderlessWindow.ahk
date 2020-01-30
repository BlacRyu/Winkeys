; Initialize variables
X := 0
Y := 0
W := A_ScreenWidth
H := A_ScreenHeight


#!Enter:: ; Win + Alt + Enter
	ToggleWindow("A")
Return

; !^w::
;	 MouseGetPos,,, window	; Use the ID of the window under the mouse.
;	 Toggle_Window(window)
; Return

ToggleWindow(window) {
	global X, Y, W, H	; Since Toggle_Window() is a function, set up X, Y, W, and H as globals
	local curStyle := WinGetStyle(window)	; Get the style of the window
	If (curStyle != "")
	{
		If (curStyle & "+0x00C40000")		; If not borderless
		{
			WinGetPos(X, Y, W, H, window)	; Store window size/location
			WinSetStyle("-0x00C40000", window)	; Remove borders
			;Sleep(1) ; wait for borders to be removed so that the window stretches appropriately
			WinMove(0, 0, A_ScreenWidth, A_ScreenHeight, window)	; Stretch to screen-size
			Return
		}
		If (curStyle & "-0x00C40000")		; If borderless
		{
			WinSetStyle("+0x00C40000", window)	; Reapply borders
			WinMove(X, Y, W, H, window)		; Return to original position
			Return
		}
	}
	; Else
	; 	MsgBox(WinGetPID(window))
	Return	; RETURN if the other IF's don't fire (shouldn't be possible in most cases)
}
