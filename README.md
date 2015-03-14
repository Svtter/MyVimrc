MyVimrc
===

- coding.net, 国内可用 http://coding.net/u/svtter/p/vimrc/   
- 本vimrc用于备份我的vimrc，也是为了通用型。
- [Task当前的任务](#task)
- [所用的插件, 来自github](#plugin)
- 包含大量的来自vim-scripts的插件
- 因为我的个人习惯会经常改动，所以想要更新朋友要做好准备，不要随便的git pull

运行截图 Running Image
---
![截图](install_pic/截屏.png)

运行环境 Environment
---

- gvim or vim, git 是必须的
- 特别的，如果你的环境是Ubuntu，直接使用: `sudo apt-get gvim git`即可


安装 Install
---

####Linux

```bash 
cd 你想要的目录/
git clone https://github.com/Svtter/MyVimrc
bash install
```

此外，还有更多的选项，可以通过`bash install help`查看

####Windows

- 尚未书写自动化的安装方法

一般的问题 FAQ
---

1. 如果出现插件不识别的情况重新安装以下vundle 
    或者打开.vimrc使用:PluginInstall命令
2. 字体出现乱码的情况：
    参见airline的FAQ，主要是ariline的字体没有安装导致.

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

Plugin
---

Plugin方面可以打开vimrc自己选择
