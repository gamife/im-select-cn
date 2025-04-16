; autohotkey v2 版本
SendMode "Input" ; Recommended for new scripts due to its superior speed and reliability.

GroupAdd "ABGroup", "ahk_exe goland64.exe"
GroupAdd "ABGroup", "ahk_exe Code.exe"

#HotIf !WinActive("ahk_group ABGroup")

CapsLock & u:: Send "+{Home}"
CapsLock & o:: Send "+{End}"
CapsLock & k:: Send "+{Up}"
CapsLock & j:: Send "+{Down}"
CapsLock & h:: Send "+{Left}"
CapsLock & l:: Send "+{Right}"

; 屏蔽掉 alt 的唤起菜单栏
~Alt:: Send "{Blind}{vkE8}"
<!u:: Send "{Home}"
<!o:: Send "{End}"
<!k:: Send "{Up}"
<!j:: Send "{Down}"
<!h:: Send "{Left}"
<!l:: Send "{Right}"

; *>!v::Send "{WheelDown}"
; *>!x::Send "{WheelUp}"

<!x:: Send "^x" ;剪切
<!c:: Send "^c" ;复制
<!v:: Send "^v" ;粘粘
<!f:: Send "^z" ;撤销
<!g:: Send "^+z" ;反撤销

#HotIf WinActive("ahk_group ABGroup")

#HotIf
#n:: { ; win+n 打开vscode
    if WinExist("Code ahk_group ABGroup")
        WinActivate ; Activate the window found above
    else
        Run "Code.exe" ; Open a new vscode window
}

*>!e:: MouseMove 0, -30, 0, "R" ; Win+UpArrow 热键 => 上移光标
*>!d:: MouseMove 0, 30, 0, "R" ; Win+DownArrow => 下移光标
*>!s:: MouseMove -30, 0, 0, "R" ; Win+LeftArrow => 左移光标
*>!f:: MouseMove 30, 0, 0, "R" ; Win+RightArrow => 右移光标
*>!Space:: {
    Click
}

CapsLock:: Send "{Esc}"
+CapsLock:: { ; shift+capslock 大小写切换
    SetCapsLockState !GetKeyState("CapsLock", "T")
}
