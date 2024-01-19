# im-select-cn
# Introduce
im-select 只能切换输入法，不能切换输入法状态，所以一直在找一个可以切换输入法状态的程序.  
im-select-cn 是用autohotkey脚本写的, 中英文切换是默认通过模拟按下shift键来切换的.  
使用的autohotkey版本是 v1.1.33.02

# Usage
## 可执行文件本身
### 切换输入法状态
```
/path/to/im-select-cn.exe 0|1|2
``` 
参数介绍:
* 0: 切换到英文
* 1: 切换到中文
* 2: 直接切换

### 获取当前输入法状态
```
/path/to/im-select-cn-test.exe
```
注意这里用的是后缀为test的可执行文件, 由于vscode的vim插件好像会执行一次不带参数的情况, 总是弹出消息框, 所以分了两个可执行文件.

## 在vscode的vim插件中使用
配置settings.json文件:
```json
// 按下ESC切换成英文输入
"vim.autoSwitchInputMethod.enable": true,
"vim.autoSwitchInputMethod.defaultIM": "0",
"vim.autoSwitchInputMethod.obtainIMCmd": "C:\\\\im-select-cn.exe",
"vim.autoSwitchInputMethod.switchIMCmd": "C:\\\\im-select-cn.exe {im}",
```

# 已自测的输入法
* 搜狗拼音 v13.10.0 正式版

# 期望改进
由于我主要是配合用在vscode的vim插件, 要是可以vscode按下ESC按键前保存中英文输入状态, 然后在insert模式下恢复原有insert模式下的中英文输入状态就好了.

# 参考文档
1. https://wyagd001.github.io/zh-cn/docs/KeyList.htm
2. https://blog.csdn.net/fgh544568/article/details/126707672