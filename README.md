# im-select-cn
# Introduce
`im-select-cn` 用来切换输入法中英文状态. 

原版`im-select` 好像只能切换输入法，不能切换输入法状态，所以一直在找一个可以切换输入法状态的程序.  
`im-select-cn` 是用autohotkey脚本写的, 使用的autohotkey版本是 v1.1.33.02.

# Usage
## 参数介绍
```
/path/to/im-select-cn.exe [-t|-c|0|1|2]
``` 
参数介绍:  
    -t: 测试当前输入法状态, 会有弹窗显示  
    -c: 相当于按下shift按键直接切换  
    数字: 切换到对应输入法状态, 1可能表示中文, 也可能是英文, 取决于输入法, 需要-t测试当前输入法状态

### 1. 获取当前输入法状态, 在中文和英文输入状态各执行一次
```
/path/to/im-select-cn.exe -t
```
### 2. 切换输入法中英文, 数字是步骤1得到中英文状态对应的数字
如果数字是不属于中英文的其他数字, 则会直接切换状态
```
/path/to/im-select-cn.exe 0|1|2
```


## 在vscode的vim插件中使用
配置settings.json文件:
```json
// 按下ESC切换成英文输入
"vim.autoSwitchInputMethod.enable": true,
// 把-t得到的英文状态对应的数字填入这里
"vim.autoSwitchInputMethod.defaultIM": "0",
"vim.autoSwitchInputMethod.obtainIMCmd": "C:\\\\im-select-cn.exe",
"vim.autoSwitchInputMethod.switchIMCmd": "C:\\\\im-select-cn.exe {im}",
```
## 在LazyVim💤中使用:
在配置文件中添加:
``` lua
return {
  "keaising/im-select.nvim",
  config = function()
    require("im_select").setup({
      default_im_select = 0,
      default_command = "D:\\im-select-cn\\im-select-cn.exe",

      -- Restore the default input method state when the following events are triggered
      set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },

      -- Restore the previous used input method state when the following events
      -- are triggered, if you don't want to restore previous used im in Insert mode,
      -- e.g. deprecated `disable_auto_restore = 1`, just let it empty
      -- as `set_previous_events = {}`
      set_previous_events = { "InsertEnter" },

      -- Show notification about how to install executable binary when binary missed
      keep_quiet_on_no_binary = false,

      -- Async run `default_command` to switch IM or not
      async_switch_im = true,
    })
  end,
}

```


## 编译
需要下载autohotkey 1.1 版本, 然后点击.ahk文件,右键点击 `compile script(GUI)` , 我选的是`v1.1.37.02 U64 Unicode 64-bit. bin`, 然后点击 `Convert`按钮就得到exe文件了.

# 已自测的输入法
* 搜狗拼音 v15.3.0.1781 正式版
* 讯飞输入法 v3.0.1738


# 参考文档
1. https://wyagd001.github.io/zh-cn/docs/KeyList.htm
2. https://blog.csdn.net/fgh544568/article/details/126707672
3. https://blog.51cto.com/u_15408625/6220547