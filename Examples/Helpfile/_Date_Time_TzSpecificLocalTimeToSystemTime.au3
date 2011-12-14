#include <GUIConstantsEx.au3>
#include <Date.au3>
#include <WindowsConstants.au3>

Global $iMemo

_Main()

Func _Main()
	Local $tLocal, $tSystem

	; 创建 GUI
	GUICreate("Time", 400, 300)
	$iMemo = GUICtrlCreateEdit("", 2, 2, 396, 296, $WS_VSCROLL)
	GUICtrlSetFont($iMemo, 9, 400, 0, "Courier New")
	GUISetState()

	; 转换系统时间到本地时间
	$tSystem = _Date_Time_GetSystemTime()
	$tLocal = _Date_Time_SystemTimeToTzSpecificLocalTime(DllStructGetPtr($tSystem))
	MemoWrite("System time to local time .: " & _Date_Time_SystemTimeToDateTimeStr($tLocal))

	$tLocal = _Date_Time_GetLocalTime()
	$tSystem = _Date_Time_TzSpecificLocalTimeToSystemTime(DllStructGetPtr($tLocal))
	MemoWrite("Local time to system time .: " & _Date_Time_SystemTimeToDateTimeStr($tSystem))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE

EndFunc   ;==>_Main

; 写入一行到 memo 控件
Func MemoWrite($sMessage)
	GUICtrlSetData($iMemo, $sMessage & @CRLF, 1)
EndFunc   ;==>MemoWrite
