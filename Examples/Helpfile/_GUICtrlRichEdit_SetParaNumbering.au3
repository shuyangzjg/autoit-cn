#include <GuiRichEdit.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $lblMsg, $hRichEdit

Main()

Func Main()
	Local $hGui, $iMsg, $btnNext, $iStep = 0
	$hGui = GUICreate("Example (" & StringTrimRight(@ScriptName, 4) & ")", 320, 350, -1, -1)
	$hRichEdit = _GUICtrlRichEdit_Create($hGui, "This is a test.", 10, 10, 300, 220, _
			BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))
	$lblMsg = GUICtrlCreateLabel("", 10, 235, 300, 60)
	$btnNext = GUICtrlCreateButton("Next", 270, 310, 40, 30)
	GUISetState()

	_GUICtrlRichEdit_SetText($hRichEdit, "First paragraph")
	_GUICtrlRichEdit_SetSel($hRichEdit, 0, 1)
	Report("Para with default indent settings")

	While True
		$iMsg = GUIGetMsg()
		Select
			Case $iMsg = $GUI_EVENT_CLOSE
				_GUICtrlRichEdit_Destroy($hRichEdit) ; 除非脚本崩溃才需要
;~ 				GUIDelete() 	; 同样行
				Exit
			Case $iMsg = $btnNext
				$iStep += 1
				Switch $iStep
					Case 1
						_GUICtrlRichEdit_AppendText($hRichEdit, @CR & "Second paragraph")
						_GUICtrlRichEdit_SetParaNumbering($hRichEdit, ".")
						Report("Added second paragraph")
					Case 2
						_GUICtrlRichEdit_SetSel($hRichEdit, 0, 2)
						Report("Style of first paragraph in the selection")
					Case 3
						_GUICtrlRichEdit_SetSel($hRichEdit, 10, 26)
						_GUICtrlRichEdit_SetParaNumbering($hRichEdit, "v)  ", Default, True)
						Report("Change settings of both paragraphs")
					Case 4
						_GUICtrlRichEdit_SetSel($hRichEdit, 10, 26)
						_GUICtrlRichEdit_SetParaNumbering($hRichEdit, "2.  ", Default, True)
						Report("Changed settings for both paragraphs")
					Case 5
						; 把所有的文本流保存到桌面,这样您可以在 Word 中查看设置.
						_GUICtrlRichEdit_Deselect($hRichEdit)
						_GUICtrlRichEdit_StreamToFile($hRichEdit, @DesktopDir & "\gcre.rtf")
						GUICtrlSetState($btnNext, $GUI_DISABLE)
				EndSwitch
		EndSelect
	WEnd
EndFunc   ;==>Main

Func Report($sMsg)
	$sMsg = $sMsg & @CR & @CR & "Get function returns " & @CR & _GUICtrlRichEdit_GetParaNumbering($hRichEdit)
	GUICtrlSetData($lblMsg, $sMsg)
	ControlFocus($hRichEdit, "", "")
EndFunc   ;==>Report
