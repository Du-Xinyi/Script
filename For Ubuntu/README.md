# #2022.12.2

## 创建basic.sh optimization.sh setup.sh(需要sudo权限) 

## 记得home路径改成自己的！！！

### basic.sh

- 更换清华源(Ubuntu 20.04)

- 安装一些其他软件
  - vim
  - net-tools
  - git
  - cmake
  - make
  - gcc
  - python3-pip
  - openssl
  - libssl-dev

- 安装OpenCV依赖

- 终端输入替换(bash)python替换python3，pip替换pip3

- pip换源(清华源)

### optimization.sh

- sudo输入免密码
- 翻墙环境配置，还要手动将Settings->Network->Network Proxy更改为Manual(重启生效)
- 修改swap大小，16G内存按1.5倍修改为24G
- 安装搜狗拼音输入法，在https://shurufa.sogou.com/下载Linux版本，并将下载包名改为sogoupinyin.deb
- 安装WPS，在https://linux.wps.cn/下载，并将下载包名改为wps-office.deb
- 安装zsh(通过oh my zsh)，终端环境改为ys，添加extract zsh-syntax-highlighting插件
- 终端输入替换(zsh)python替换python3，pip替换pip3
- 视频播放器及图片查看器
- 标题栏监控Indicator-sysmonitor(开机自启需手动设置)
- 备份Timeshift
- 文档Typora
- 修正因为双系统导致的Windows时间错误
- 改rEFInd引导后关闭ubuntu的grub引导界面

### setup.sh

两个脚本的合一版本