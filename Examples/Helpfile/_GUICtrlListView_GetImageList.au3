#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>

$Debug_LV = False ; 检查传递给 ListView 函数的类名, 设置为True并输出到一个控件的句柄,用于检查它是否工作

_Main()

Func _Main()
	Local $hImage, $hListView

	GUICreate("ListView Get Image List", 400, 300)
	$hListView = GUICtrlCreateListView("", 2, 2, 394, 268)
	GUISetState()

	; 加载图像
	$hImage = _GUIImageList_Create()
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($hListView, 0xFF0000, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($hListView, 0x00FF00, 16, 16))
	_GUIImageList_Add($hImage, _GUICtrlListView_CreateSolidBitMap($hListView, 0x0000FF, 16, 16))
	_GUICtrlListView_SetImageList($hListView, $hImage, 1)

	; 添加列
	_GUICtrlListView_AddColumn($hListView, "Column 1", 100)
	_GUICtrlListView_AddColumn($hListView, "Column 2", 100)
	_GUICtrlListView_AddColumn($hListView, "Column 3", 100)

	; 添加项目
	_GUICtrlListView_AddItem($hListView, "Item 1", 0)
	_GUICtrlListView_AddItem($hListView, "Item 2", 1)
	_GUICtrlListView_AddItem($hListView, "Item 3", 2)

	; Get image list handle
	MsgBox(4160, "信息", "Image List Handle: 0x" & Hex(_GUICtrlListView_GetImageList($hListView, 1)) & @CRLF & _
			"IsPtr = " & IsPtr(_GUICtrlListView_GetImageList($hListView, 1)) & " IsHWnd = " & IsHWnd(_GUICtrlListView_GetImageList($hListView, 1)))

	; 循环直到用户退出
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	GUIDelete()
EndFunc   ;==>_Main
