#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

; 获取命令行参数的数量
ArgCount := A_Args.Count()

if (ArgCount > 1) {
    MsgBox
    (
    命令行参数最多一个: 

    -t: 测试当前输入法状态
    -c: 相当于按下shift按键
    数字: 切换到对应输入法状态, 1可能表示中文, 也可能是英文, 取决于输入法, 需要-t测试当前输入法状态
    )
}
; 当前输入法状态
current_IME := IME_GET()

; 打印当前输入法状态, 标准输出stdout
if (ArgCount == 0){
    ; 可能使用windows的命令行看不到输出
    ; 由 Gilmour6415 issue#1 提供的写法, 到时候把这注释删掉再pr
    FileAppend, %current_IME%, *
    ExitApp, 0
}

; 命令行参数的第一个参数下标为1
expect_IME := A_Args[1]

; 打印当前输入法状态, 弹窗
if (expect_IME == "-t"){
    MsgBox 当前输入法状态为: %current_IME%
    ExitApp, 0
}

; 直接按下 shift 按键
if (expect_IME == "-c"){
    Send {Shift} 
    ExitApp, 0
}

if (expect_IME != current_IME){
    ; 如果参数 expect_IME 不对应输入法的中文或英文, 会直接切换中英文
    Send {Shift} 
    ; 只对部分输入法有效
    ; IME_SET(expect_IME)
}

; 获取输入法的中英文状态
; 输入法实测返回的数字
;      中文,英文
; 讯飞: 2,1
; 搜狗: 1,2
IME_GET(WinTitle=""){
    if (WinTitle == "" ){
        WinTitle := "A"
    }
    WinGet,hWnd,ID,%WinTitle%
    DefaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)

    DetectSave := A_DetectHiddenWindows
    DetectHiddenWindows,ON
    ;Message : WM_IME_CONTROL  wParam:IMC_GETOPENSTATUS
    SendMessage 0x283, 0x005,0,,ahk_id %DefaultIMEWnd%
    DetectHiddenWindows,%DetectSave%
    Return ErrorLevel
}

; 设置输入法的中英文状态
; 实测对以下输入法无效
; 讯飞,
; 实测对以下输入法有效
; 搜狗,
IME_SET(setSts, WinTitle=""){
    if (WinTitle == "" ){
        WinTitle := "A"
    }
    ; ifEqual WinTitle,,  SetEnv,WinTitle,A
    WinGet,hWnd,ID,%WinTitle%
    DefaultIMEWnd := DllCall("imm32\ImmGetDefaultIMEWnd", Uint,hWnd, Uint)
    DetectSave := A_DetectHiddenWindows
    DetectHiddenWindows,ON 
    ; Message : WM_IME_CONTROL  wParam:IMC_SETOPENSTATUS
    SendMessage 0x283, 0x006,setSts,,ahk_id %DefaultIMEWnd%
    DetectHiddenWindows,%DetectSave%
    Return ErrorLevel
}

