#!/bin/bash

# sudo输入免密码(用" "会导致不包含空格等)
sudo sed -i 's/%sudo   ALL=(ALL:ALL) ALL/%sudo   ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers
echo 'sudo nopasswd set success'

# 换源
sudo sed -i "s@http://.*archive.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
sudo sed -i "s@http://.*security.ubuntu.com@https://mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
sudo apt update
echo 'update success'

# 翻墙环境配置
sudo echo " " >> /etc/environment
sudo echo "http_proxy=http://127.0.0.1:7890/" >> /etc/environment
sudo echo "https_proxy=http://127.0.0.1:7890/" >> /etc/environment
sudo echo "ftp_proxy=http://127.0.0.1:7890/" >> /etc/environment
sudo echo "HTTP_PROXY=http://127.0.0.1:7890/" >> /etc/environment
sudo echo "HTTPS_PROXY=http://127.0.0.1:7890/" >> /etc/environment
sudo echo "FTP_PROXY=http://127.0.0.1:7890/" >> /etc/environment
echo 'environment set success'

# 修改swap大小
sudo swapoff /swapfile
sudo rm /swapfile
sudo dd if=/dev/zero of=/swapfile bs=1G count=24
sudo chmod 0600 swapfile
sudo mkswap -f swapfile
sudo swapon /swapfile
echo 'swap expansion success'

# 安装其他工具及框架
sudo apt install -y vim net-tools git cmake make gcc python3-pip openssl libssl-dev libfreeimage3 libfreeimage-dev

# OpenCV依赖大全
sudo apt-get install -y build-essential cmake git unzip pkg-config zlib1g-dev
sudo apt-get install -y libjpeg-dev libjpeg8-dev libjpeg-turbo8-dev
sudo apt-get install -y libpng-dev libtiff-dev libglew-dev
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install -y libgtk2.0-dev libgtk-3-dev libcanberra-gtk-dev
sudo apt-get install -y python-all-dev python-setuptools python-wheel
sudo apt-get install -y python3-dev python3-numpy python3-pip
sudo apt-get install -y libxvidcore-dev libx264-dev libgtk-3-dev
sudo apt-get install -y libtbb2 libtbb-dev libdc1394-22-dev libxine2-dev
sudo apt-get install -y gstreamer1.0-tools libgstreamer-plugins-base1.0-dev
sudo apt-get install -y libgstreamer-plugins-good1.0-dev
sudo apt-get install -y libqt5core5a libqt5gui5 libqt5opengl5 libqt5widgets5 
sudo apt-get install -y libv4l-dev v4l-utils qv4l2
sudo apt-get install -y libtesseract-dev libxine2-dev libpostproc-dev
sudo apt-get install -y libavresample-dev libvorbis-dev
sudo apt-get install -y libfaac-dev libmp3lame-dev libtheora-dev
sudo apt-get install -y libopencore-amrnb-dev libopencore-amrwb-dev
sudo apt-get install -y libopenblas-dev libatlas-base-dev libblas-dev
sudo apt-get install -y liblapack-dev liblapacke-dev libeigen3-dev gfortran
sudo apt-get install -y libhdf5-dev libprotobuf-dev protobuf-compiler
sudo apt-get install -y libgoogle-glog-dev libgflags-dev
sudo apt-get install -y libgphoto2-dev

# zsh(需要重新登入才能生效)
sudo apt install -y zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i "s/robbyrussell/ys/" /home/duxinyi/.zshrc
sed -i 's/plugins=(git)/plugins=(git extract zsh-syntax-highlighting)/' /home/duxinyi/.zshrc
source ~/.zshrc

# 终端输入替换
echo " " >> /home/duxinyi/.zshrc
echo 'alias python="/usr/bin/python3"' >> /home/duxinyi/.zshrc
echo 'alias pip="/usr/bin/pip3"' >> /home/duxinyi/.zshrc

# pip换源
python -m pip install --upgrade pip
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

# ROS2
sudo apt install -y curl gnupg2 lsb-release
curl http://repo.ros2.org/repos.key | sudo apt-key add -
sudo sh -c 'echo "deb http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
sudo sed -i 's/deb /deb [arch=amd64] /' /etc/apt/sources.list.d
sudo apt install -y ros-foxy-desktop
echo "source /opt/ros/foxy/setup.zsh" >> ~/.zshrc
source ~/.zshrc

# 搜狗拼音输入法
sudo apt install -y fcitx libqt5qml5 libqt5quick5 libqt5quickwidgets5 qml-module-qtquick2 libgsettings-qt1
sudo dpkg -i sogoupinyin.deb

# WPS
sudo dpkg -i wps-office.deb
unzip wps_symbol_fonts.zip
sudo mv mtextra.ttf /usr/share/fonts
sudo mv symbol.ttf /usr/share/fonts
sudo mv WEBDINGS.ttf /usr/share/fonts
sudo mv wingding.ttf /usr/share/fonts
sudo mv WINGDNG2.ttf /usr/share/fonts
sudo mv WINGDNG3.ttf /usr/share/fonts

# 视频播放器及图片查看器
sudo apt install -y vlc gwenview

# 标题栏监控Indicator-sysmonitor
sudo add-apt-repository ppa:fossfreedom/indicator-sysmonitor
sudo apt-get update
sudo apt-get install -y indicator-sysmonitor

# 备份Timeshift
sudo apt-add-repository -y ppa:teejee2008/ppa
sudo apt-get update
sudo apt-get install -y timeshift

# 文档Typora
wget -qO - https://typoraio.cn/linux/public-key.asc | sudo tee /etc/apt/trusted.gpg.d/typora.asc
sudo add-apt-repository -y 'deb https://typoraio.cn/linux ./'
sudo apt-get update
sudo apt-get install typora

# 修正因为双系统导致的Windows时间错误
sudo apt install -y ntpdate
sudo ntpdate time.windows.com
sudo hwclock --localtime --systohc

# 改rEFInd引导后关闭ubuntu的grub引导界面
sudo sed -i 's/set timeout=10/set timeout=0/' /etc/grub.d/30_os-prober
sudo sed -i 's/GRUB_TIMEOUT=10/GRUB_TIMEOUT=0/' /etc/default/grub
sudo update-grub
echo 'grub-update success'
