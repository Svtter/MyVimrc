MyVimrc
===

- [task](#task)
- backup myvimrc to avoid lose it
- 里面包含大量的来自vim-scripts的插件

运行截图:
===
- [截图](install_pic/截屏.png)

Install
---

###1.With Ubuntu
#### setup .vimrc

```bash 
cd 你想要的目录/
git clone https://github.com/Svtter/MyVimrc
sudo bash install
```
编辑.vimrc文件，输入:PluginInstall命令安装插件

###2.With Windows

- 首先你需要安装`git`这个工具
- 不安也行，下载右边的zip也行

然后剩下的复制粘贴吧，有时间我再写。
不过最简单的解决方案就是转移到Linux。
不爽你就咬我啊。

FAQ
---

1. 可能install脚本不够好用，存在部分问题。
2. 如果出现插件不识别的情况重新安装以下vundle 
    或者打开.vimrc使用:PluginInstall命令

### 字体自己手动安装

Function
---
- press F4 add my information to source file
- press F9 to compile the cpp file
- press F8 to use gdb debug
- press F2 to open NerdTree (File anager)
- press tl to open tagelist

Task
---
- [ ] add task.vim
- [ ] use gdb
