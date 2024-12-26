# im-select-cn
Fork自[gamife/im-select-cn](https://github.com/gamife/im-select-cn)

解决了原作者希望Vscode插件能记忆Input模式的输入法,从而在切换到Normal模式时,能自动切换到上一次的输入法状态的问题。

详见[issue](https://github.com/gamife/im-select-cn/issues/1)

实现原理：第一次调用im-method-cn.exe时，vscode或者nvim的插件是不传参数给im-method-cn.exe的，此时im-method-cn.exe不会有任何返回值，因此vscode接收不到当前输入法状态，自然无法记忆当前输入法。

## 此项目做了什么

通过观察ahk脚本代码得知，原作者通过Msgbox来获取当前输入法状态，这样虽有醒目弹窗提示，但是Vscode或者neovim并不会接受到任何返回值。

因此我修改了ahk脚本，将Msgbox改为FileAppend，这样就能模拟标准输出，并使得Vscode或者neovim插件能成功读取当前输入法状态，从而实现记忆当前输入法状态的功能。


---
## 项目介绍
为Windows下的Vim用户提供新的输入法切换工具：保持输入法选择，并只切换输入法的中英文状态，而不是直接切换输入法。

原版的 im-select 在Windows下只能切换输入法，而不能切换输入法状态，换句话说，每次按下esc键切换到normal模式的时候，im-select 会先切换到微软美式键盘，然后在编辑模式的时候，再切换回简体中文键盘，这样的交互逻辑实际上是存在问题的。

举个例子，我们按下esc进入normal模式之后，我需要在别的什么软件里输入中文，结果那个软件却并没有及时切换到中文键盘，而是继续保持在美式键盘（我相信在Windows下使用过im-select的朋友应该都遇到过，这样的交互痛点即使开启了系统自动为每个窗口记住输入法也时常发生）。

此时，如果我们习惯性的按下shift或者别的什么按键去将输入法从英文切换为中文是不成功的，因为美式键盘并没有拼音输入法，所以我们需要先按下ctrl+shift去切换输入法，然后再按下shift去切换输入法状态，这样的交互逻辑显然是繁琐的，而且容易出错。

## 现有解决方案
[daipeihust/im-select/tree/master/win-mspy](https://github.com/daipeihust/im-select/tree/master/win-mspy)
原理是通过 UIAutomation 来获取当前输入法的信息, 然后通过 SendInput 来模拟按键来切换输入法.
但配置较为繁琐



而原项目[gamife/im-select-cn](https://github.com/gamife/im-select-cn)
提供了一个使用autohotkey实现的全新解决方案,关键工作原理是使用Windows的IME api来读取和切换输入法状态，因此无需配置 

### 工作原理

#### 关键 Windows API

##### `ImmGetDefaultIMEWnd`
- 来源于 `imm32.dll`。
- 用于获取与目标窗口关联的输入法窗口句柄。

##### `WM_IME_CONTROL` 消息
- 用于控制输入法的状态。

**`wParam` 参数：**
- `IMC_SETOPENSTATUS`（值为 `0x006`）：设置输入法的状态。

**`lParam` 参数：**
- `1`：启用输入法。
- `0`：禁用输入法。

---

#### 切换机制
1. 通过调用 `ImmGetDefaultIMEWnd` 获取目标窗口的默认输入法窗口句柄。
2. 使用 `SendMessage` 发送 `WM_IME_CONTROL` 消息，控制输入法的开关状态。

本项目fork自[gamife/im-select-cn](https://github.com/gamife/im-select-cn),是用autohotkey脚本写的, 使用的autohotkey版本是 v1.1

# 使用方法
见项目原页面[gamife/im-select-cn](https://github.com/gamife/im-select-cn)





# 实测支持输入法
> * 搜狗拼音
> * 微软拼音
