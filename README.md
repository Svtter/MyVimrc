MyVimrc
===

- 本vimrc用于备份我的vimrc，也是为了通用型。
- [Task](#task)
- 包含大量的来自vim-scripts的插件
- 因为我的个人习惯会经常改动，所以想要更新朋友要做好准备，不要随便的git pull

运行截图 Running Image
---
![截图](install_pic/截屏.png)

运行环境 Environment
---

- gvim or vim, git
- 特别的，如果你的环境是Ubuntu，直接使用:
- `sudo apt-get gvim git`即可


安装 Install
---

####Linux

```bash 
cd 你想要的目录/
git clone https://github.com/Svtter/MyVimrc
sudo bash install
```

此外，还有更多的选项，可以通过`bash install help`查看

####Windows

- 首先你需要安装`git`这个工具
- 不安也行，下载右边的zip也行

然后剩下的复制粘贴吧，有时间我再写。
不过最简单的解决方案就是转移到Linux。
不爽你就咬我啊。

一般的问题 FAQ
---

1. 如果出现插件不识别的情况重新安装以下vundle 
    或者打开.vimrc使用:PluginInstall命令

功能 Function
---

- 更多功能，请细看vimrc
- press F4 添加个人信息
- press F9 编译运行cpp
- press F8 使用gdb调试
- press F2 打开nerdtree
- press tl 打开taglist 

Task
---

- [ ] add task.vim
- [x] use gdb
- [ ] 对过于特殊的配置进行重构

